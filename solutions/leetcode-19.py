# Definition for singly-linked list.
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next
class Solution:
    def removeNthFromEnd(self, head: Optional[ListNode], n: int) -> Optional[ListNode]:
        
        _p1_head = ListNode(0, head)
        p1, p2 = _p1_head, head
        
        while n:
            n -= 1
            p2 = p2.next
        
        while p2:
            p1, p2 = p1.next, p2.next
        
        p1.next = p1.next.next
        
        return _p1_head.next