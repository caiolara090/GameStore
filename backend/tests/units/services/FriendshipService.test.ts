import { FriendshipServices } from '../../../src/domain/services/FriendshipServices';
import { IFriendshipRepository } from '../../../src/domain/ports/Friendship/FriendshipRepository';
import { IFriendship } from '../../../src/domain/entities/Friendship';

describe('FriendshipServices', () => {
  let friendshipServices: FriendshipServices;
  let mockFriendshipRepository: jest.Mocked<IFriendshipRepository>;

  beforeEach(() => {
    mockFriendshipRepository = {
      create: jest.fn(),
      findByUsers: jest.fn(),
      update: jest.fn(),
      delete: jest.fn(),
      find: jest.fn()
    } as unknown as jest.Mocked<IFriendshipRepository>;

    friendshipServices = new FriendshipServices();
    (friendshipServices as any).friendshipRepository = mockFriendshipRepository;
  });

  describe('createFriendshipRequest', () => {
    it('should create a friendship request successfully', async () => {
      mockFriendshipRepository.findByUsers.mockResolvedValueOnce(null);

      await friendshipServices.createFriendshipRequest('user1', 'user2');

      expect(mockFriendshipRepository.create).toHaveBeenCalledTimes(2);
    });

    it('should throw an error if friendship already exists', async () => {
      mockFriendshipRepository.findByUsers.mockResolvedValueOnce({} as IFriendship);

      await expect(
        friendshipServices.createFriendshipRequest('user1', 'user2')
      ).rejects.toThrow('Friendship already exists.');
    });
  });

  describe('acceptFriendshipRequest', () => {
    it('should accept a friendship request successfully', async () => {
      mockFriendshipRepository.findByUsers
        .mockResolvedValueOnce({ _id: '1', status: 1 } as IFriendship)
        .mockResolvedValueOnce({ _id: '2', status: 0 } as IFriendship);

      await friendshipServices.acceptFriendshipRequest('user1', 'user2');

      expect(mockFriendshipRepository.update).toHaveBeenCalledTimes(2);
    });

    it('should throw an error if friendship request not found', async () => {
      mockFriendshipRepository.findByUsers.mockResolvedValueOnce(null);

      await expect(
        friendshipServices.acceptFriendshipRequest('user1', 'user2')
      ).rejects.toThrow('Friendship request not found');
    });
  });

  describe('rejectFriendshipRequest', () => {
    it('should reject a friendship request successfully', async () => {
      mockFriendshipRepository.findByUsers
        .mockResolvedValueOnce({ _id: '1', status: 1 } as IFriendship)
        .mockResolvedValueOnce({ _id: '2', status: 0 } as IFriendship);

      await friendshipServices.rejectFriendshipRequest('user1', 'user2');

      expect(mockFriendshipRepository.delete).toHaveBeenCalledTimes(2);
    });

    it('should throw an error if friendship request not found', async () => {
      mockFriendshipRepository.findByUsers.mockResolvedValueOnce(null);

      await expect(
        friendshipServices.rejectFriendshipRequest('user1', 'user2')
      ).rejects.toThrow('Friendship request not found');
    });
  });

  describe('delete', () => {
    it('should delete a friendship successfully', async () => {
      mockFriendshipRepository.findByUsers
        .mockResolvedValueOnce({ _id: '1' } as IFriendship)
        .mockResolvedValueOnce({ _id: '2' } as IFriendship);

      await friendshipServices.delete('user1', 'user2');

      expect(mockFriendshipRepository.delete).toHaveBeenCalledTimes(2);
    });

    it('should not throw an error if friendship not found', async () => {
      mockFriendshipRepository.findByUsers.mockResolvedValueOnce(null);

      await expect(
        friendshipServices.delete('user1', 'user2')
      ).resolves.not.toThrow();
    });
  });

  describe('find', () => {
    it('should find friendships based on criteria', async () => {
      const friendship = { userId: 'user1', friendId: 'user2' };
      mockFriendshipRepository.find.mockResolvedValueOnce([friendship] as IFriendship[]);

      const result = await friendshipServices.find(friendship);

      expect(result).toEqual([friendship]);
    });
  });
});
