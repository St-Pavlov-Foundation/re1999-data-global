module("modules.common.others.UIBlockHelper", package.seeall)

slot0 = class("UIBlockHelper")

function slot0._init(slot0)
	if not slot0._inited then
		slot0._inited = true
		slot0._blockTimeDict = {}
		slot0._blockViewDict = {}
		slot0._blockViewCount = {}
		slot0._nextRemoveBlockTime = 0

		setmetatable(slot0._blockViewCount, {
			__index = function ()
				return 0
			end
		})
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	end
end

function slot0.startBlock(slot0, slot1, slot2, slot3)
	slot0:_init()

	if slot0._blockTimeDict[slot1] and slot0._blockViewDict[slot1] ~= slot3 then
		logError("不支持改变绑定的界面")

		return
	end

	slot2 = slot2 or 0.1

	UIBlockMgr.instance:startBlock(slot1)

	if slot3 and not slot0._blockTimeDict[slot1] then
		slot0._blockViewDict[slot1] = slot3
		slot0._blockViewCount[slot3] = slot0._blockViewCount[slot3] + 1
	end

	slot0._blockTimeDict[slot1] = UnityEngine.Time.time + slot2

	slot0:_checkNextRemoveBlock()
end

function slot0.endBlock(slot0, slot1)
	if not slot0._blockTimeDict or not slot0._blockTimeDict[slot1] then
		return
	end

	slot0:_endBlock(slot1)
	slot0:_checkNextRemoveBlock()
end

function slot0._checkNextRemoveBlock(slot0)
	slot2 = math.huge

	for slot6, slot7 in pairs(slot0._blockTimeDict) do
		if slot7 < UnityEngine.Time.time then
			slot0:endBlock(slot6)
		elseif slot7 < slot2 then
			slot2 = slot7
		end
	end

	if slot2 ~= math.huge then
		if slot2 ~= slot0._nextRemoveBlockTime then
			slot0._nextRemoveBlockTime = slot2

			TaskDispatcher.cancelTask(slot0._checkNextRemoveBlock, slot0)
			TaskDispatcher.runDelay(slot0._checkNextRemoveBlock, slot0, slot2 - slot1)
		end
	elseif slot0._nextRemoveBlockTime ~= 0 then
		slot0._nextRemoveBlockTime = 0

		TaskDispatcher.cancelTask(slot0._checkNextRemoveBlock, slot0)
	end
end

function slot0._endBlock(slot0, slot1)
	UIBlockMgr.instance:endBlock(slot1)

	slot0._blockTimeDict[slot1] = nil

	if slot0._blockViewDict[slot1] then
		slot2 = slot0._blockViewDict[slot1]
		slot0._blockViewCount[slot2] = slot0._blockViewCount[slot2] - 1

		if slot0._blockViewCount[slot2] == 0 then
			slot0._blockViewCount[slot2] = nil
		end
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot0._blockViewCount[slot1] > 0 then
		for slot5, slot6 in pairs(slot0._blockViewDict) do
			if slot6 == slot1 then
				slot0:endBlock(slot5)
			end
		end

		slot0:_checkNextRemoveBlock()
	end
end

function slot0.clearAll(slot0)
	if not slot0._blockTimeDict then
		return
	end

	for slot4 in pairs(slot0._blockTimeDict) do
		slot0:_endBlock(slot4)
	end

	slot0._nextRemoveBlockTime = 0

	TaskDispatcher.cancelTask(slot0._checkNextRemoveBlock, slot0)
end

slot0.instance = slot0.New()

return slot0
