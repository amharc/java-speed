class Node
	attr_accessor :key, :children

	def initialize(key)
		@key, @children = key, []
	end

	def link(that)
		if that.nil? then
			return self
		elsif key > that.key then
			return that.link(self)
		else
			children << that
			return self
		end
	end

	def self.merge_list(children)
		if children.empty? then
			nil
		elsif children.length == 1 then
			children[0]
		else
			rem = Node.merge_list(children[2..-1])
			return children[0].link(children[1]).link(rem)
		end
	end

	def merged_children
		new = Node.merge_list(children.reverse)
		children = []
		return new
	end
end

class Heap
	@root = nil

	def top
		return @root.key
	end

	def pop
		@root = @root.merged_children
	end

	def insert(key)
		@root = Node.new(key).link(@root)
	end
end

heap = Heap.new

STDIN.read.split("\n").each do |line|
	words = line.split(" ")

	if words[0] == "0" then
		heap.insert(words[1].to_i)
	elsif words[0] == '1' then
		puts heap.top
	else
		heap.pop
	end
end
