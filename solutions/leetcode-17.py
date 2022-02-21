class Solution:
    def maxArea(self, H: List[int]) -> int:
        
        l, r = 0, len(H) - 1
        max_val = 0
        
        
        while l <= r:
            while l <= r and H[l] >= H[r]:
                max_val = max(max_val, H[r] * (r - l))
                r -= 1
            while l <= r and H[r] >= H[l]:
                max_val = max(max_val, H[l] * (r - l))
                l += 1
                
        return max_val