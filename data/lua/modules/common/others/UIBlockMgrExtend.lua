module("modules.common.others.UIBlockMgrExtend", package.seeall)

slot0 = class("UIBlockMgrExtend", LuaCompBase)
slot1 = "ui/viewres/common/blockanimui.prefab"
slot2 = "UIRoot/TOP/UIEndBlock"
slot3 = "effects/prefabs/weak_network"
slot4 = "effects/prefabs/weak_network/weak_network_effect_loop.prefab"
slot5 = "effects/prefabs/weak_network/weak_network_effect_end.prefab"
slot6 = 2
slot7 = 1.2
slot8 = true
slot0.CircleMvDelay = nil

function slot0.setNeedCircleMv(slot0)
	if uv0 ~= slot0 then
		if canLogNormal then
			logNormal((slot0 and "显示菊花" or "隐藏菊花") .. debug.traceback("", 2))
		end

		uv0 = slot0
	end
end

function slot0.preload(slot0, slot1)
	uv0._callback = slot0
	uv0._callbackObj = slot1
	uv0._loader = PrefabInstantiate.Create(UIBlockMgr.instance:getBlockGO())

	uv0._loader:startLoad(uv1, uv0._onCallback)
end

function slot0._onCallback()
	if uv0._callback then
		uv0._callback(uv0._callbackObj)
	end

	uv0._callback = nil
	uv0._callbackObj = nil
	slot1 = MonoHelper.addNoUpdateLuaComOnceToGo(UIBlockMgr.instance:getBlockGO(), uv0)

	slot1:setGO(uv0._loader:getInstGO())

	uv0.instance = slot1
end

function slot0.getEndUIBlockGo()
	if not uv0._endUIBlockGo then
		uv0._endUIBlockGo = gohelper.find(uv1)
	end

	return uv0._endUIBlockGo
end

function slot0.setGO(slot0, slot1)
	slot0._loopGoWrapper = slot1
	slot0._endGoWrapper = gohelper.clone(slot0._loopGoWrapper, uv0.getEndUIBlockGo(), "endblockanimui")
	slot0.isPlay = false

	if GameResMgr.IsFromEditorDir then
		loadAbAsset(uv1, false, slot0._onLoopLoadCallback, slot0)
		loadAbAsset(uv2, false, slot0._onEndLoadCallback, slot0)
	else
		loadAbAsset(uv3, false, slot0._onAbLoadCallback, slot0)
	end

	slot0._txt = gohelper.findChildText(slot1, "Text")
	slot0._clickCounter = 0

	SLFramework.UGUI.UIClickListener.Get(slot1.transform.parent.gameObject):AddClickListener(slot0._onClickBlock, slot0)
end

function slot0.setTips(slot0, slot1)
	if gohelper.isNil(slot0._txt) then
		return
	end

	if string.nilorempty(slot1) then
		slot0._txt.text = "CONNECTING"
	else
		slot0._txt.text = slot1
	end
end

function slot0._onClickBlock(slot0)
	slot0._clickCounter = slot0._clickCounter + 1

	if slot0._clickCounter == 30 then
		slot1 = {}

		for slot5, slot6 in pairs(UIBlockMgr.instance._blockKeyDict) do
			table.insert(slot1, slot5)
		end

		if #slot1 == 1 and slot1[1] == UIBlockKey.MsgLock then
			if #ConnectAliveMgr.instance:getUnresponsiveMsgList() == 0 then
				UIBlockMgr.instance:endAll()
				logError("没有要等待的回包，关闭遮罩")

				return
			end

			if not isDebugBuild then
				return
			end
		end

		if isDebugBuild and tabletool.indexOf(slot1, UIBlockKey.MsgLock) then
			for slot7, slot8 in ipairs(slot2) do
				slot3 = string.format("%s%s,", "", slot8.msg.__cname)
			end

			logError(string.format("Block Msg count=%d: %s", #slot2, slot3))
		end

		logError("BlockKeys: " .. table.concat(slot1, ","))
	end
end

function slot0._onLoopLoadCallback(slot0, slot1)
	if slot1.IsLoadSuccess then
		slot1:Retain()
		gohelper.clone(slot1:GetResource(uv0), gohelper.findChild(slot0._loopGoWrapper, "network_wrapper"))
	end
end

function slot0._onEndLoadCallback(slot0, slot1)
	if slot1.IsLoadSuccess then
		slot1:Retain()
		gohelper.clone(slot1:GetResource(uv0), gohelper.findChild(slot0._endGoWrapper, "network_wrapper"))
	end
end

function slot0._onAbLoadCallback(slot0, slot1)
	if slot1.IsLoadSuccess then
		slot1:Retain()
		gohelper.clone(slot1:GetResource(uv0), gohelper.findChild(slot0._loopGoWrapper, "network_wrapper"))
		gohelper.clone(slot1:GetResource(uv1), gohelper.findChild(slot0._endGoWrapper, "network_wrapper"))
	end
end

function slot0.onEnable(slot0)
	slot0._clickCounter = 0

	TaskDispatcher.cancelTask(slot0._onEndAnimationFinished, slot0)
	gohelper.setActive(uv0.getEndUIBlockGo(), false)
	gohelper.setActive(slot0._loopGoWrapper, false)

	if uv1 then
		TaskDispatcher.runDelay(slot0._onDelayShow, slot0, uv0.CircleMvDelay and uv0.CircleMvDelay > 0 and uv0.CircleMvDelay or uv2)
	end
end

function slot0.onDisable(slot0)
	slot0._clickCounter = 0

	TaskDispatcher.cancelTask(slot0._onDelayShow, slot0)
	gohelper.setActive(slot0._loopGoWrapper, false)

	if not slot0.isPlay then
		return
	end

	if uv0 then
		gohelper.setActive(uv1.getEndUIBlockGo(), true)
		TaskDispatcher.runDelay(slot0._onEndAnimationFinished, slot0, uv2)
	end
end

function slot0._onDelayShow(slot0)
	if not uv0 then
		return
	end

	gohelper.setActive(slot0._loopGoWrapper, true)

	slot0.isPlay = true
	slot1 = {}

	for slot5, slot6 in pairs(UIBlockMgr.instance._blockKeyDict) do
		table.insert(slot1, slot5)
	end

	logNormal("BlockKeys: " .. table.concat(slot1, ","))
end

function slot0._onEndAnimationFinished(slot0)
	slot0.isPlay = false

	TaskDispatcher.cancelTask(slot0._onEndAnimationFinished, slot0)
	gohelper.setActive(uv0.getEndUIBlockGo(), false)
end

return slot0
