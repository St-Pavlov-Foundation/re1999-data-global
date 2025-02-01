module("modules.logic.rouge.map.view.map.RougeMapView", package.seeall)

slot0 = class("RougeMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtTitleName = gohelper.findChildText(slot0.viewGO, "Top/#txt_TitleName")
	slot0._gorougeherogroup = gohelper.findChild(slot0.viewGO, "Left/#go_rougeherogroup")
	slot0._goroucollection = gohelper.findChild(slot0.viewGO, "Left/#go_rougecollection")
	slot0._gorougelv = gohelper.findChild(slot0.viewGO, "Left/#go_rougelv")
	slot0._goMask = gohelper.findChild(slot0.viewGO, "#go_Mask")
	slot0._goFocusPos = gohelper.findChild(slot0.viewGO, "#go_focusposition")
	slot0.goswitchmapanim = gohelper.findChild(slot0.viewGO, "#go_excessive")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.goHeroGroup = slot0.viewContainer:getResInst(RougeEnum.ResPath.CommonHeroGroupItem, slot0._gorougeherogroup)
	slot0.goCollection = slot0.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, slot0._goroucollection)
	slot0.goLv = slot0.viewContainer:getResInst(RougeEnum.ResPath.CommonLvItem, slot0._gorougelv)
	slot0.groupComp = RougeHeroGroupComp.Get(slot0.goHeroGroup)
	slot0.collectionComp = RougeCollectionComp.Get(slot0.goCollection)
	slot0.lvComp = RougeLvComp.Get(slot0.goLv)
	slot0.viewRectTr = slot0.viewGO:GetComponent(gohelper.Type_RectTransform)

	RougeMapModel.instance:setFocusScreenPosX(recthelper.uiPosToScreenPos2(slot0._goFocusPos.transform))

	slot0.animator = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0.openRightView = false

	gohelper.setActive(slot0.goswitchmapanim, false)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onBeforeChangeMapInfo, slot0.onBeforeChangeMapInfo, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, slot0.onChangeMapInfo, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onCreateMapDoneFlowDone, slot0.onCreateMapDoneFlowDone, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView, slot0)
	NavigateMgr.instance:addEscape(slot0.viewName, RougeMapHelper.backToMainScene, nil)
end

function slot0._initNeedPlayOpenAnimView(slot0)
	if slot0.needPlayOpenAnimViewDict then
		return
	end

	slot0.needPlayOpenAnimViewDict = {
		[ViewName.RougeMapChoiceView] = true,
		[ViewName.RougeTeamView] = true,
		[ViewName.RougeCollectionChessView] = true,
		[ViewName.RougeTalentView] = true,
		[ViewName.RougeMapPieceChoiceView] = true
	}
end

function slot0.onOpenView(slot0, slot1)
	slot0:_initNeedPlayOpenAnimView()

	if slot0.needPlayOpenAnimViewDict[slot1] then
		slot0.animator:Play("close", 0, 0)
	end
end

function slot0.onCloseView(slot0, slot1)
	slot0:_initNeedPlayOpenAnimView()

	if slot0.needPlayOpenAnimViewDict[slot1] then
		slot0.animator:Play("open", 0, 0)
	end
end

function slot0.onBeforeChangeMapInfo(slot0)
	gohelper.setActive(slot0.goswitchmapanim, true)
	TaskDispatcher.runDelay(slot0.onAnimDone, slot0, RougeMapEnum.SwitchMapAnimDuration)
end

function slot0.onCreateMapDoneFlowDone(slot0)
	slot0:playNormalLayerAudio()
end

function slot0.onChangeMapInfo(slot0)
	slot0._txtTitleName.text = RougeMapModel.instance:getMapName()
end

function slot0.onAnimDone(slot0)
	gohelper.setActive(slot0.goswitchmapanim, false)
end

function slot0.onOpen(slot0)
	slot0.groupComp:onOpen()
	slot0.collectionComp:onOpen(RougeEnum.CollectionEntryState.Icon)
	slot0.lvComp:onOpen()

	slot0._txtTitleName.text = RougeMapModel.instance:getMapName()

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onFocusNormalLayerActor)
end

function slot0.playNormalLayerAudio(slot0)
	if RougeMapModel.instance:isNormalLayer() then
		AudioMgr.instance:trigger(AudioEnum.UI.LineExpanded)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.onAnimDone, slot0)
	slot0.groupComp:onClose()
	slot0.collectionComp:onClose()
	slot0.lvComp:onClose()
end

function slot0.onDestroyView(slot0)
	slot0.groupComp:destroy()
	slot0.collectionComp:destroy()
	slot0.lvComp:destroy()
end

return slot0
