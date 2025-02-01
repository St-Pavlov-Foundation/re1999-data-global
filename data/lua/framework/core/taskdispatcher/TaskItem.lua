module("framework.core.taskdispatcher.TaskItem", package.seeall)

slot0 = class("TaskItem")
slot0.IsIOSPlayer = SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.IOSPlayer
slot0.frameCount = 0
slot0._itemPool = nil
slot1 = __G__TRACKBACK__
slot2 = xpcall

function slot0.createPool()
	uv0._itemPool = LuaObjPool.New(32, uv0._poolNew, uv0._poolRelease, uv0._poolReset)

	return uv0._itemPool
end

function slot0._poolNew()
	return uv0.New()
end

function slot0._poolRelease(slot0)
	slot0:release()
end

function slot0._poolReset(slot0)
	slot0:reset()
end

function slot0.reset(slot0)
	slot0.interval = 0
	slot0.addFrame = 0
	slot0.timeCount = 0

	slot0:setCb(nil, )

	slot0.repeatCount = 0
	slot0.isLoop = false
	slot0.hasInvoked = false
	slot0.status = TaskDispatcher.Idle
end

function slot0.ctor(slot0)
	slot0:reset()
end

function slot0.release(slot0)
	slot0:reset()
end

function slot0.setCb(slot0, slot1, slot2)
	slot0.callback = slot1
	slot0.cbObj = slot2
end

function slot0.update(slot0, slot1)
	if slot0.status == TaskDispatcher.ToDelete then
		slot0.repeatCount = 0

		return false
	end

	slot0.hasInvoked = false

	if uv0.frameCount <= slot0.addFrame then
		return slot0.hasInvoked
	end

	slot0.timeCount = slot0.timeCount + slot1

	if slot0.timeCount < slot0.interval then
		return slot0.hasInvoked
	end

	slot0.hasInvoked = true
	slot0.timeCount = slot0.timeCount - slot0.interval

	if slot0.cbObj then
		uv1(slot0.callback, uv2, slot0.cbObj)
	else
		uv1(slot0.callback, uv2)
	end

	slot0.repeatCount = slot0.repeatCount - 1

	return slot0.hasInvoked
end

function slot0.logStr(slot0)
	return "callback = " .. tostring(slot0.callback) .. " cbObj = " .. tostring(slot0.cbObj) .. " interval = " .. slot0.interval .. " addFrame = " .. slot0.addFrame .. " timeCount = " .. slot0.timeCount .. " repeatCount = " .. slot0.repeatCount .. " isLoop = " .. tostring(slot0.isLoop) .. " hasInvoked = " .. tostring(slot0.hasInvoked) .. " status = " .. slot0.status
end

return slot0
