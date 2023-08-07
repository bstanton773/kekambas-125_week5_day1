# Given an array nums, write a function to move all 0's to the end of it 
# while maintaining the relative order of the non-zero elements.
# Example:
# Input: [0,1,0,3,12]
# Output: [1,3,12,0,0]
# Example Input: [0,0,11,2,3,4]					
# Example Output: [11,2,3,4,0,0]

# def solution(nums):
#     num_zeros = 0
#     output = []
#     for num in nums:
#         if num == 0:
#             num_zeros += 1
#         else:
#             output.append(num)
#     for _ in range(num_zeros):
#         output.append(0)
#     return output

# def solution(nums):
#     num_zeros = 0
#     i = 0
#     while i < len(nums):
#         if nums[i] == 0:
#             num_zeros += 1
#             nums.pop(i)
#         else:
#             i += 1
#     for _ in range(num_zeros):
#         nums.append(0)
#     return nums


def solution(lst):
    empty_list = []
    while 0 in lst: # O(n)
        empty_list.append(0) # O(1)
        lst.remove(0) # O(n)
    for num in empty_list:
        if num == 0:
            lst.append(num)
    return lst


def solution(nums):
    return [num for num in nums if num != 0] + [0] * nums.count(0)
