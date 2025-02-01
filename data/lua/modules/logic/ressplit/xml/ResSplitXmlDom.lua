module("modules.logic.ressplit.xml.ResSplitXmlDom", package.seeall)

slot1 = function ()
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
end()

function slot1.new(slot0)
	slot1 = uv0()
	slot1.__index = slot0

	setmetatable(slot1, slot0)

	return slot1
end

function slot1.starttag(slot0, slot1)
	slot2 = {
		_type = "ELEMENT",
		_name = slot1.name,
		_attr = slot1.attrs,
		_children = {}
	}

	if slot0.root == nil then
		slot0.root = slot2
	end

	table.insert(slot0._stack, slot2)
	table.insert(slot0.current._children, slot2)

	slot0.current = slot2
end

function slot1.endtag(slot0, slot1, slot2)
	if slot1.name ~= slot0._stack[#slot0._stack]._name then
		error("XML Error - Unmatched Tag [" .. slot2 .. ":" .. slot1.name .. "]\n")
	end

	table.remove(slot0._stack)

	slot0.current = slot0._stack[#slot0._stack]
end

function slot1.text(slot0, slot1)
	table.insert(slot0.current._children, {
		_type = "TEXT",
		_text = slot1
	})
end

function slot1.comment(slot0, slot1)
	if slot0.options.commentNode then
		table.insert(slot0.current._children, {
			_type = "COMMENT",
			_text = slot1
		})
	end
end

function slot1.pi(slot0, slot1)
	if slot0.options.piNode then
		table.insert(slot0.current._children, {
			_type = "PI",
			_name = slot1.name,
			_attr = slot1.attrs
		})
	end
end

function slot1.decl(slot0, slot1)
	if slot0.options.declNode then
		table.insert(slot0.current._children, {
			_type = "DECL",
			_name = slot1.name,
			_attr = slot1.attrs
		})
	end
end

function slot1.dtd(slot0, slot1)
	if slot0.options.dtdNode then
		table.insert(slot0.current._children, {
			_type = "DTD",
			_name = slot1.name,
			_attr = slot1.attrs
		})
	end
end

slot1.cdata = slot1.text
slot1.__index = slot1

return slot1
