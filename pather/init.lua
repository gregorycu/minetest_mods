minetest.register_node("pather:src", {
	description = "Src",
	tiles = {"source.png", "source.png", "source.png", "source.png", "source.png", "source.png"},
	on_construct = function(pos)
		local timer = minetest.get_node_timer(pos)
		pos.y = pos.y + 1
		
		if src ~= nil then
			minetest.remove_node(src)
		end
		
		src = pos
	
		timer:start(1)
	end,
	groups = {cracky = 3, stone = 2, oddly_breakable_by_hand = 2, },
	
	on_timer = function(pos, elapsed)
		
		local timer = minetest.get_node_timer(pos)
		timer:start(1)
		
		if src == nil then return end
		if dest == nil then return end
		
		player = minetest.get_player_by_name('singleplayer')
		if player == nil then return end

		tool = player:get_wielded_item()
		if tool == nil then return end
		
		tool = tool:get_name()
		
		start = os.clock()
		
		for i=1,1000 do
		--path = nil
		--if tool == "pather:src_cat" then
			path = minetest.find_path(src,dest,100,{max_jump_height=2, max_drop_height=2, swimming_above=false, swimming_surface=false})
		--end
		
		--if tool == "pather:src_dog" then
			--path = minetest.find_path(src,dest,100,{swimming_surface=true})
		--end
		
		--if tool == "pather:src_duck" then
			--path = minetest.find_path(src,dest,100,{swimming_above=true})
		--end
		
		end
		
		print((os.clock() - start) * 1000)
		
		if path == nil then return end
		
		minetest.log("error", "Path with length " ..table.getn(path) )
		for k,v in pairs(path) do
		
			minetest.add_particle({
				pos = v,
				velocity = {x=0, y=0.2, z=0},
				acceleration = {x=0, y=0, z=0},
				expirationtime = 1,
				size = 5,
				collisiondetection = false,
				vertical = false,
				texture = "path.png"
			})
		end
		
		return false
	end,
	
	after_destruct = function(pos, oldnode)
		src = nil
	end,
})

minetest.register_node("pather:dest", {
	description = "Dest",
	tiles = {"dest.png", "dest.png", "dest.png", "dest.png", "dest.png", "dest.png"},
	on_construct = function(pos)
		pos.y = pos.y + 1
		
		if dest ~= nil then
			minetest.remove_node(dest)
		end
		
		dest = pos
	end,
	groups = {cracky = 3, stone = 2, oddly_breakable_by_hand = 2},
	after_destruct = function(pos, oldnode)
		dest = nil
	end,
	
})

minetest.register_node("pather:src_cat", {
	description = "Cat",
	tiles = {"source_cat.png", "source_cat.png", "source_cat.png", "source_cat.png", "source_cat.png", "source_cat.png"},
	groups = {cracky = 3, stone = 2, oddly_breakable_by_hand = 2},
})

minetest.register_node("pather:src_dog", {
	description = "Dog",
	tiles = {"source_dog.png", "source_dog.png", "source_dog.png", "source_dog.png", "source_dog.png", "source_dog.png"},
	groups = {cracky = 3, stone = 2, oddly_breakable_by_hand = 2},
})

minetest.register_node("pather:src_duck", {
	description = "Duck",
	tiles = {"source_duck.png", "source_duck.png", "source_duck.png", "source_duck.png", "source_duck.png", "source_duck.png"},
	groups = {cracky = 3, stone = 2, oddly_breakable_by_hand = 2},
})


