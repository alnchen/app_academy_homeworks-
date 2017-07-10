def kth_largest(tree_node, k)
  all_nums = in_order_traversal(tree_node)
  all_nums[all_nums.length - k]
end

def in_order_traversal(tree_node = @root, arr = [])
  return if tree_node.nil?

  in_order_traversal(tree_node.left, arr)
  arr << tree_node
  in_order_traversal(tree_node.right, arr)

  arr
end
