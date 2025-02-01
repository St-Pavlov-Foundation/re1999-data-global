module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapTrapItem", package.seeall)

slot0 = class("VersionActivity_1_2_DungeonMapTrapItem", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._topRight = gohelper.findChild(slot0.viewGO, "topRight")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeElementView, slot0._btncloseOnClick, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeChildElementView, slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	SLFramework.AnimatorPlayer.Get(slot0.viewGO):Play("close", nil, )

	slot0._closeTween = ZProj.TweenHelper.DOTweenFloat(5, 6.75, 0.5, slot0._tweenFloatFrameCb, slot0.DESTROYSELF, slot0)
end

function slot0.onRefreshViewParam(slot0, slot1)
	slot0._config = slot1
end

function slot0.onOpen(slot0)
	MainCameraMgr.instance:setLock(true)
	gohelper.setActive(slot0.viewGO, false)

	slot0._trapIds = VersionActivity1_2DungeonModel.instance.trapIds
	slot0._putTrap = VersionActivity1_2DungeonModel.instance.putTrap
	slot1 = {}
	slot6 = slot0._config.id

	for slot6, slot7 in pairs(VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(slot6)) do
		table.insert(slot1, slot7)

		if not slot0._modelItem then
			slot0._modelItem = gohelper.findChild(slot0.viewGO, "Root/rotate/choicelayout/choice")

			table.insert({}, slot0._modelItem)
		else
			table.insert(slot2, gohelper.cloneInPlace(slot0._modelItem))
		end
	end

	table.sort(slot1, function (slot0, slot1)
		return slot0.id < slot1.id
	end)

	for slot6, slot7 in ipairs(slot1) do
		slot0:openSubView(VersionActivity_1_2_DungeonMapTrapChildItem, slot2[slot6], nil, slot7)
	end

	TaskDispatcher.runDelay(slot0._showOpenCameraAni, slot0, 0.3)
end

function slot0._showOpenCameraAni(slot0)
	gohelper.setActive(slot0.viewGO, true)

	slot0._openTween = ZProj.TweenHelper.DOTweenFloat(6.75, 5, 0.5, slot0._tweenFloatFrameCb, nil, slot0)
end

function slot0._tweenFloatFrameCb(slot0, slot1)
	CameraMgr.instance:getMainCamera().orthographicSize = slot1
end

function slot0._showCurrency(slot0)
	slot0:com_loadAsset(CurrencyView.prefabPath, slot0._onCurrencyLoaded)
end

function slot0._onCurrencyLoaded(slot0, slot1)
	slot6 = slot0:openSubView(CurrencyView, gohelper.clone(slot1:GetResource(), slot0._topRight), nil, {
		CurrencyEnum.CurrencyType.DryForest
	})
	slot6.foreShowBtn = true

	slot6:_hideAddBtn(CurrencyEnum.CurrencyType.DryForest)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showOpenCameraAni, slot0)

	if slot0._openTween then
		ZProj.TweenHelper.KillById(slot0._openTween)
	end

	if slot0._closeTween then
		ZProj.TweenHelper.KillById(slot0._closeTween)
	end

	MainCameraMgr.instance:setLock(false)
end

function slot0.onDestroyView(slot0)
end

return slot0
