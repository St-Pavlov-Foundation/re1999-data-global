module("modules.logic.ressplit.xml.ResSplitXmlDom", package.seeall)

local function var_0_0()
	return {
		options = {
			declNode = 1,
			dtdNode = 1,
			piNode = 1,
			commentNode = 1
		},
		current = {
			_type = "ROOT",
			_children = {}
		},
		_stack = {}
	}
end

local var_0_1 = var_0_0()

function var_0_1.new(arg_2_0)
	local var_2_0 = var_0_0()

	var_2_0.__index = arg_2_0

	setmetatable(var_2_0, arg_2_0)

	return var_2_0
end

function var_0_1.starttag(arg_3_0, arg_3_1)
	local var_3_0 = {
		_type = "ELEMENT",
		_name = arg_3_1.name,
		_attr = arg_3_1.attrs,
		_children = {}
	}

	if arg_3_0.root == nil then
		arg_3_0.root = var_3_0
	end

	table.insert(arg_3_0._stack, var_3_0)
	table.insert(arg_3_0.current._children, var_3_0)

	arg_3_0.current = var_3_0
end

function var_0_1.endtag(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0._stack[#arg_4_0._stack]

	if arg_4_1.name ~= var_4_0._name then
		error("XML Error - Unmatched Tag [" .. arg_4_2 .. ":" .. arg_4_1.name .. "]\n")
	end

	table.remove(arg_4_0._stack)

	arg_4_0.current = arg_4_0._stack[#arg_4_0._stack]
end

function var_0_1.text(arg_5_0, arg_5_1)
	local var_5_0 = {
		_type = "TEXT",
		_text = arg_5_1
	}

	table.insert(arg_5_0.current._children, var_5_0)
end

function var_0_1.comment(arg_6_0, arg_6_1)
	if arg_6_0.options.commentNode then
		local var_6_0 = {
			_type = "COMMENT",
			_text = arg_6_1
		}

		table.insert(arg_6_0.current._children, var_6_0)
	end
end

function var_0_1.pi(arg_7_0, arg_7_1)
	if arg_7_0.options.piNode then
		local var_7_0 = {
			_type = "PI",
			_name = arg_7_1.name,
			_attr = arg_7_1.attrs
		}

		table.insert(arg_7_0.current._children, var_7_0)
	end
end

function var_0_1.decl(arg_8_0, arg_8_1)
	if arg_8_0.options.declNode then
		local var_8_0 = {
			_type = "DECL",
			_name = arg_8_1.name,
			_attr = arg_8_1.attrs
		}

		table.insert(arg_8_0.current._children, var_8_0)
	end
end

function var_0_1.dtd(arg_9_0, arg_9_1)
	if arg_9_0.options.dtdNode then
		local var_9_0 = {
			_type = "DTD",
			_name = arg_9_1.name,
			_attr = arg_9_1.attrs
		}

		table.insert(arg_9_0.current._children, var_9_0)
	end
end

var_0_1.cdata = var_0_1.text
var_0_1.__index = var_0_1

return var_0_1
