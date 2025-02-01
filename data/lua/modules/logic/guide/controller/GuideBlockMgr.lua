module("modules.logic.guide.controller.GuideBlockMgr", package.seeall)

slot0 = class("GuideBlockMgr")
slot0.BlockTime = 0.5

function slot0.ctor(slot0)
	slot0._eventSystemGO = nil
	slot0._startBlockTime = nil
	slot0._blockTime = nil
	slot0._isBlock = false
end

function slot0.startBlock(slot0, slot1)
	if not slot0._eventSystemGO then
		slot0._eventSystemGO = gohelper.find("EventSystem")

		if not slot0._eventSystemGO then
			logError("can't find EventSystem GO")
		end

		TaskDispatcher.runRepeat(slot0._onTick, slot0, 0.2)
	end

	if not slot0._startBlockTime then
		slot0._isBlock = true

		gohelper.setActive(slot0._eventSystemGO, false)

		ZProj.TouchEventMgr.Fobidden = true
	end

	slot0._startBlockTime = Time.time
	slot0._blockTime = slot1 or uv0.BlockTime
end

function slot0.removeBlock(slot0)
	slot0:_removeBlock()
end

function slot0._removeBlock(slot0)
	slot0._startBlockTime = nil
	slot0._isBlock = false

	gohelper.setActive(slot0._eventSystemGO, true)

	ZProj.TouchEventMgr.Fobidden = false
end

function slot0.isBlock(slot0)
	return slot0._isBlock
end

function slot0._onTick(slot0)
	if slot0._startBlockTime and slot0._blockTime <= Time.time - slot0._startBlockTime then
		slot0:_removeBlock()
	end
end

slot0.instance = slot0.New()

return slot0
