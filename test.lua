

local str = '{{.data={msg_kv={{.data={key="user_name",str_value="TestName_Andy"}},{.data={key="Uid",int_value=9}},{.data={key="time",int_value=1560441716}}},msg_type="create_league"}},{.data={msg_kv={{.data={key="user_name",str_value="TestName_Andy"}},{.data={key="Uid",int_value=2}},{.data={key="time",int_value=1560442041}}},msg_type="new_member"}},{.data={msg_kv={{.data={key="user_name",str_value="TestName_Andy"}},{.data={key="Uid",int_value=2}},{.data={key="time",int_value=1560442051}}},msg_type="new_member"}}}'



local tb = {}
for i =1 ,#str do 
	local d=string.sub(str, i , i)
	table.insert(tb, d)
end 

local stack = {}

deepcopy = function(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end

    return _copy(object)
end

local copyTb = deepcopy(tb )
-- print(#copyTb)
local deleteValue = 0
for i=1 , #tb do
	if i > 6 then  
		local tempStr = table.concat(tb, "", i-6, i)
		-- print(tempStr)
		-- print(tb[i])
		if tempStr == ".data={"  then 
			table.insert(stack, tempStr)
		end 

		if tb[i] == "{" and tempStr ~= ".data={" then 
			table.insert(stack, tb[i])
		end 

		if tb[i]== "}" then 

			-- table.remove(stack, #stack)

			if stack[#stack] == ".data={" then
				table.remove(stack, #stack)
					-- print("====",copyTb[i-deleteValue],copyTb[i-deleteValue +1], copyTb[i-deleteValue+2])
				table.remove(copyTb, i-deleteValue)
				-- print(copyTb[i-deleteValue-1],copyTb[i-deleteValue],copyTb[i-deleteValue +1], copyTb[i-deleteValue+2])
				deleteValue = deleteValue + 1 

			else 
				table.remove(stack, #stack)
			end 

		end 
	end 
end 

-- print(#copyTb)
local newStr = table.concat(copyTb,"")
local endStr = string.gsub(newStr , "%.data={", "")

print(endStr)

