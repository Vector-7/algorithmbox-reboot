class Solution:
    def search(self, nums: List[int], target: int) -> int:
        
        ans = -1
        N = len(nums)
        start_p = nums.index(min(nums))
        
        hash_vkey = lambda k: (k-start_p) % N
        unhash_vkey = lambda k:(k+start_p) % N
        
        vl, vr = 0, N-1
        while vl <= vr:
            vmid = (vl+vr)>>1
            e = nums[unhash_vkey(vmid)]
            
            if e == target:
                return unhash_vkey(vmid)
            elif e > target:
                vr = vmid - 1
            else:
                vl = vmid + 1
        return -1