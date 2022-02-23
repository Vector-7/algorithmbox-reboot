class Solution:
    def nextPermutation(self, nums: List[int]) -> None:
        if len(nums) < 3:
            nums.reverse()
        else:
            n = len(nums)
            l, r = -1, -1
            for i in range(n-2, -1, -1):
                if nums[i] < nums[i+1]:
                    l = i
                    break
            if l == -1:
                nums.reverse()
                return
            for i in range(n-1, i, -1):
                if nums[l] < nums[i]:
                    r = i
                    break
            nums[r], nums[l] = nums[l], nums[r]
            
            for i in range(l+1, (l+n+1)>>1):
                start, end = i, n-i+l
                nums[start], nums[end] = nums[end], nums[start]
        