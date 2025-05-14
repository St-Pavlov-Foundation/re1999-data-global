module("modules.logic.ressplit.xml.ResSplitXmlTree", package.seeall)

local function var_0_0()
	local var_1_0 = {
		root = {},
		options = {
			noreduce = {
				SoundBank = true,
				Event = true,
				File = true
			}
		}
	}

	var_1_0._stack = {
		var_1_0.root
	}

	return var_1_0
end

local var_0_1 = var_0_0()

function var_0_1.new(arg_2_0)
	local var_2_0 = var_0_0()

	var_2_0.__index = arg_2_0

	setmetatable(var_2_0, arg_2_0)

	return var_2_0
end

function var_0_1.reduce(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		if type(iter_3_1) == "table" then
			arg_3_0:reduce(iter_3_1, iter_3_0, arg_3_1)
		end
	end

	if #arg_3_1 == 1 and not arg_3_0.options.noreduce[arg_3_2] and arg_3_1._attr == nil then
		arg_3_3[arg_3_2] = arg_3_1[1]
	end
end

local function var_0_2(arg_4_0)
	if #arg_4_0 == 0 then
		local var_4_0 = {}

		table.insert(var_4_0, arg_4_0)

		return var_4_0
	end

	return arg_4_0
end

function var_0_1.starttag(arg_5_0, arg_5_1)
	local var_5_0 = {}

	if arg_5_0.parseAttributes == true then
		var_5_0._attr = arg_5_1.attrs
	end

	local var_5_1 = arg_5_0._stack[#arg_5_0._stack]

	if var_5_1[arg_5_1.name] then
		local var_5_2 = var_0_2(var_5_1[arg_5_1.name])

		table.insert(var_5_2, var_5_0)

		var_5_1[arg_5_1.name] = var_5_2
	else
		var_5_1[arg_5_1.name] = {
			var_5_0
		}
	end

	table.insert(arg_5_0._stack, var_5_0)
end

function var_0_1.endtag(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._stack[#arg_6_0._stack - 1]

	if not var_6_0[arg_6_1.name] then
		error("XML Error - Unmatched Tag [" .. arg_6_2 .. ":" .. arg_6_1.name .. "]\n")
	end

	if var_6_0 == arg_6_0.root then
		arg_6_0:reduce(var_6_0, nil, nil)
	end

	table.remove(arg_6_0._stack)
end

function var_0_1.text(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._stack[#arg_7_0._stack]

	table.insert(var_7_0, arg_7_1)
end

var_0_1.cdata = var_0_1.text
var_0_1.__index = var_0_1

return var_0_1
