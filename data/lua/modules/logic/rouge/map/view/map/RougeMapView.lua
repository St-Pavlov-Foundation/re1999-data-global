module("modules.logic.rouge.map.view.map.RougeMapView", package.seeall)

local var_0_0 = class("RougeMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtTitleName = gohelper.findChildText(arg_1_0.viewGO, "Top/#txt_TitleName")
	arg_1_0._gorougeherogroup = gohelper.findChild(arg_1_0.viewGO, "Left/#go_rougeherogroup")
	arg_1_0._goroucollection = gohelper.findChild(arg_1_0.viewGO, "Left/#go_rougecollection")
	arg_1_0._gorougelv = gohelper.findChild(arg_1_0.viewGO, "Left/#go_rougelv")
	arg_1_0._goMask = gohelper.findChild(arg_1_0.viewGO, "#go_Mask")
	arg_1_0._goFocusPos = gohelper.findChild(arg_1_0.viewGO, "#go_focusposition")
	arg_1_0.goswitchmapanim = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.goHeroGroup = arg_4_0.viewContainer:getResInst(RougeEnum.ResPath.CommonHeroGroupItem, arg_4_0._gorougeherogroup)
	arg_4_0.goCollection = arg_4_0.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, arg_4_0._goroucollection)
	arg_4_0.goLv = arg_4_0.viewContainer:getResInst(RougeEnum.ResPath.CommonLvItem, arg_4_0._gorougelv)
	arg_4_0.groupComp = RougeHeroGroupComp.Get(arg_4_0.goHeroGroup)
	arg_4_0.collectionComp = RougeCollectionComp.Get(arg_4_0.goCollection)
	arg_4_0.lvComp = RougeLvComp.Get(arg_4_0.goLv)
	arg_4_0.viewRectTr = arg_4_0.viewGO:GetComponent(gohelper.Type_RectTransform)

	local var_4_0 = recthelper.uiPosToScreenPos2(arg_4_0._goFocusPos.transform)

	RougeMapModel.instance:setFocusScreenPosX(var_4_0)

	arg_4_0.animator = arg_4_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_4_0.openRightView = false

	gohelper.setActive(arg_4_0.goswitchmapanim, false)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onBeforeChangeMapInfo, arg_4_0.onBeforeChangeMapInfo, arg_4_0)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, arg_4_0.onChangeMapInfo, arg_4_0)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onCreateMapDoneFlowDone, arg_4_0.onCreateMapDoneFlowDone, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_4_0.onOpenView, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0.onCloseView, arg_4_0)
	NavigateMgr.instance:addEscape(arg_4_0.viewName, RougeMapHelper.backToMainScene, nil)
end

function var_0_0._initNeedPlayOpenAnimView(arg_5_0)
	if arg_5_0.needPlayOpenAnimViewDict then
		return
	end

	arg_5_0.needPlayOpenAnimViewDict = {
		[ViewName.RougeMapChoiceView] = true,
		[ViewName.RougeTeamView] = true,
		[ViewName.RougeCollectionChessView] = true,
		[ViewName.RougeTalentView] = true,
		[ViewName.RougeMapPieceChoiceView] = true
	}
end

function var_0_0.onOpenView(arg_6_0, arg_6_1)
	arg_6_0:_initNeedPlayOpenAnimView()

	if arg_6_0.needPlayOpenAnimViewDict[arg_6_1] then
		arg_6_0.animator:Play("close", 0, 0)
	end
end

function var_0_0.onCloseView(arg_7_0, arg_7_1)
	arg_7_0:_initNeedPlayOpenAnimView()

	if arg_7_0.needPlayOpenAnimViewDict[arg_7_1] then
		arg_7_0.animator:Play("open", 0, 0)
	end
end

function var_0_0.onBeforeChangeMapInfo(arg_8_0)
	gohelper.setActive(arg_8_0.goswitchmapanim, true)
	TaskDispatcher.runDelay(arg_8_0.onAnimDone, arg_8_0, RougeMapEnum.SwitchMapAnimDuration)
end

function var_0_0.onCreateMapDoneFlowDone(arg_9_0)
	arg_9_0:playNormalLayerAudio()
end

function var_0_0.onChangeMapInfo(arg_10_0)
	arg_10_0._txtTitleName.text = RougeMapModel.instance:getMapName()
end

function var_0_0.onAnimDone(arg_11_0)
	gohelper.setActive(arg_11_0.goswitchmapanim, false)
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0.groupComp:onOpen()
	arg_12_0.collectionComp:onOpen(RougeEnum.CollectionEntryState.Icon)
	arg_12_0.lvComp:onOpen()

	arg_12_0._txtTitleName.text = RougeMapModel.instance:getMapName()

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onFocusNormalLayerActor)
end

function var_0_0.playNormalLayerAudio(arg_13_0)
	if RougeMapModel.instance:isNormalLayer() then
		AudioMgr.instance:trigger(AudioEnum.UI.LineExpanded)
	end
end

function var_0_0.onClose(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.onAnimDone, arg_14_0)
	arg_14_0.groupComp:onClose()
	arg_14_0.collectionComp:onClose()
	arg_14_0.lvComp:onClose()
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0.groupComp:destroy()
	arg_15_0.collectionComp:destroy()
	arg_15_0.lvComp:destroy()
end

return var_0_0
