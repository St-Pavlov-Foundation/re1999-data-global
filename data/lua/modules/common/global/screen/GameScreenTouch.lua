module("modules.common.global.screen.GameScreenTouch", package.seeall)

slot0 = class("GameScreenTouch")
slot1 = 120

function slot0.ctor(slot0)
	slot0._globalTouchGO = gohelper.create2d(ViewMgr.instance:getUILayer(UILayerName.Top), "GlobalTouch")
	slot0._globalTouch = TouchEventMgrHepler.getTouchEventMgr(slot0._globalTouchGO)

	slot0._globalTouch:SetIgnoreUI(true)
	slot0._globalTouch:SetOnlyTouch(true)
	slot0._globalTouch:SetOnTouchDownCb(slot0._onTouchDownCb, slot0)
	slot0._globalTouch:SetOnTouchUp(slot0._onTouchUpCb, slot0)

	slot0._gamepadModel = SDKNativeUtil.isGamePad()

	slot0:_loadEffect()
	TaskDispatcher.runRepeat(slot0._onTick, slot0, 5)
	GameStateMgr.instance:registerCallback(GameStateEvent.onApplicationPause, slot0._onApplicationPause, slot0)
end

function slot0.playTouchEffect(slot0, slot1)
	slot0:_playTouchEffect(slot1)
end

function slot0._onTick(slot0)
	slot1 = Time.realtimeSinceStartup

	if slot0._lastTime and uv0 < slot1 - slot0._lastTime then
		slot0._lastTime = slot1

		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 1, slot0)
	end
end

function slot0._onApplicationPause(slot0, slot1)
	if slot1 then
		slot0._lastTime = Time.realtimeSinceStartup
	end
end

function slot0._onTouchDownCb(slot0)
	GameStateMgr.instance:dispatchEvent(GameStateEvent.OnTouchScreen)

	if slot0._gamepadModel == false and GMFightShowState.screenTouchEffect then
		slot0._lastTime = Time.realtimeSinceStartup

		slot0:_playTouchEffect()
	end
end

function slot0._onTouchUpCb(slot0)
	GameStateMgr.instance:dispatchEvent(GameStateEvent.OnTouchScreenUp)
end

function slot0._loadEffect(slot0)
	slot0._maxNum = 7
	slot0._effectNum = 4
	slot0._effectIndex = slot0._maxNum
	slot0._effectTabs = {}
	slot0._effectUrl = "ui/viewres/common/common_click.prefab"
	slot0._effectLoader = MultiAbLoader.New()

	slot0._effectLoader:addPath(slot0._effectUrl)
	slot0._effectLoader:startLoad(slot0._createEffect, slot0)
end

function slot0._createEffect(slot0, slot1)
	slot6 = slot0._effectUrl
	slot0._effectPrefab = slot1:getAssetItem(slot0._effectUrl):GetResource(slot6)

	for slot6 = 1, slot0._effectNum do
		slot0:_create(slot0._effectPrefab)
	end
end

function slot0._create(slot0, slot1)
	slot2 = {
		go = slot3,
		recycleFunc = function ()
			uv0:_recycleEffect(uv1)
		end
	}
	slot3 = gohelper.clone(slot1, slot0._globalTouchGO, "touchEffect")
	slot4 = gohelper.findChildImage(slot3, "image")
	slot4.material = UnityEngine.Object.Instantiate(slot4.material)
	slot6 = slot3:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	slot6.mas:Clear()
	slot6.mas:Add(slot4.material)
	gohelper.setActive(slot3, false)
	table.insert(slot0._effectTabs, slot2)

	return slot2
end

function slot0._getEffect(slot0)
	for slot4 = 1, #slot0._effectTabs do
		if slot0._effectTabs[slot4].go.activeInHierarchy == false then
			slot0._effectIndex = slot4

			return slot0._effectTabs[slot4]
		end
	end

	if #slot0._effectTabs < slot0._maxNum then
		if not slot0._effectPrefab then
			return
		end

		return slot0:_create(slot0._effectPrefab)
	else
		slot0._effectIndex = (slot0._effectIndex + 1) % slot0._maxNum

		if slot0._effectIndex <= 0 then
			slot0._effectIndex = slot0._maxNum
		end

		slot0:_recycleEffect(slot0._effectTabs[slot0._effectIndex].go)

		return slot0._effectTabs[slot0._effectIndex]
	end
end

function slot0._playTouchEffect(slot0, slot1)
	if not slot0:_canShowEffect() then
		return
	end

	if slot0:_getEffect() then
		slot3 = slot2.go:GetComponent(typeof(UnityEngine.Animation))
		slot4 = recthelper.screenPosToAnchorPos(slot1 or UnityEngine.Input.mousePosition, slot0._globalTouchGO.transform)

		recthelper.setAnchor(slot2.go.transform, slot4.x, slot4.y)
		slot3:Stop()
		gohelper.setActive(slot2.go, true)
		slot3:Play()
		TaskDispatcher.runDelay(slot2.recycleFunc, slot0, 0.7)
	end
end

function slot0._recycleEffect(slot0, slot1)
	gohelper.setActive(slot1, false)
	slot1:GetComponent(typeof(UnityEngine.Animation)):Stop()
	recthelper.setAnchor(slot1.transform, 0, 0)
end

function slot0._canShowEffect(slot0)
	slot1 = ViewMgr.instance:getOpenViewNameList()

	if slot1[#slot1] == ViewName.DungeonView and DungeonModel.instance:getDungeonStoryState() or slot1[#slot1] == ViewName.FightView and FightModel.instance:getClickEnemyState() then
		return false
	end

	return true
end

return slot0
