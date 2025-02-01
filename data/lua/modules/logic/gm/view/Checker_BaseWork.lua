module("modules.logic.gm.view.Checker_BaseWork", package.seeall)

slot0 = class("Checker_BaseWork", BaseWork)

function slot0.endBlock(slot0, slot1)
	if not slot0:isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock(slot1)
end

function slot0.startBlock(slot0, slot1)
	if slot0:isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock(slot1)
end

function slot0.isBlock(slot0)
	return UIBlockMgr.instance:isBlock() and true or false
end

function slot0.readAllText(slot0, slot1)
	if not io.open(slot1, "r") then
		logError("[readAllText] file open failed: " .. slot1)

		return false
	end

	slot2:close()

	return true, slot2:read("*a")
end

function slot0.writeAllText(slot0, slot1, slot2)
	if not io.open(slot1, "w+") then
		logError("[writeAllText] file open failed: " .. slot1)

		return false
	end

	slot3:write(slot2)
	slot3:close()

	return true
end

return slot0
