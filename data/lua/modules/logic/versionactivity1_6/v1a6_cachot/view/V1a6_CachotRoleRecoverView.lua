module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRecoverView", package.seeall)

local var_0_0 = class("V1a6_CachotRoleRecoverView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_view")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_left")
	arg_1_0._simageselect = gohelper.findChildSingleImage(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_left/#simage_select")
	arg_1_0._gopresetcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_left/scroll_view/Viewport/#go_presetcontent")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_right")
	arg_1_0._gopreparecontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_right/scroll_view/Viewport/#go_preparecontent")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")
	arg_1_0._gostart = gohelper.findChild(arg_1_0.viewGO, "#go_start")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_start/#btn_start")
	arg_1_0._gostartlight = gohelper.findChild(arg_1_0.viewGO, "#go_start/#btn_start/#go_startlight")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstart:RemoveClickListener()
end

function var_0_0._btnstartOnClick(arg_4_0)
	if not arg_4_0._selectedMo or not arg_4_0._selectedMo:getHeroMO() then
		GameFacade.showToast(ToastEnum.V1a6CachotToast10)

		return
	end

	local var_4_0 = arg_4_0._selectedMo:getHeroMO()

	RogueRpc.instance:sendRogueEventSelectRequest(V1a6_CachotEnum.ActivityId, arg_4_0.viewParam.eventId, var_4_0.heroId, arg_4_0._onSelectEnd, arg_4_0)
end

function var_0_0._onSelectEnd(arg_5_0)
	V1a6_CachotController.instance:openV1a6_CachotRoleRecoverResultView({
		arg_5_0._selectedMo
	})
end

function var_0_0._btncloseOnClick(arg_6_0)
	RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, arg_6_0.viewParam.eventId, arg_6_0.closeThis, arg_6_0)
end

function var_0_0._editableInitView(arg_7_0)
	V1a6_CachotRoleRecoverPresetListModel.instance:initList()
	V1a6_CachotRoleRecoverPrepareListModel.instance:initList()

	arg_7_0._contentSizeFitter = arg_7_0._gocontent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
	arg_7_0._horizontal = arg_7_0._gocontent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	arg_7_0._limitedScrollRect = arg_7_0._scrollview:GetComponent(typeof(ZProj.LimitedScrollRect))

	arg_7_0:_initPresetItemList()
end

function var_0_0._initPresetItemList(arg_8_0)
	if arg_8_0._presetItemList then
		return
	end

	arg_8_0._presetItemList = arg_8_0:getUserDataTb_()

	local var_8_0 = arg_8_0.viewContainer:getSetting().otherRes[1]

	for iter_8_0 = 1, V1a6_CachotEnum.HeroCountInGroup do
		local var_8_1 = arg_8_0:getResInst(var_8_0, arg_8_0._gopresetcontent, "item" .. tostring(iter_8_0))
		local var_8_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1, V1a6_CachotRoleRecoverPresetItem)

		arg_8_0._presetItemList[iter_8_0] = var_8_2
	end
end

function var_0_0._initPrepareItemList(arg_9_0)
	if arg_9_0._prepareItemList then
		return
	end

	arg_9_0._prepareItemList = arg_9_0:getUserDataTb_()

	local var_9_0 = arg_9_0.viewContainer:getSetting().otherRes[2]
	local var_9_1 = V1a6_CachotRoleRecoverPrepareListModel.instance:getList()

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2 = arg_9_0:getResInst(var_9_0, arg_9_0._gopreparecontent, "item" .. tostring(iter_9_0))
		local var_9_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_2, V1a6_CachotRoleRecoverPrepareItem)

		arg_9_0._prepareItemList[iter_9_0] = var_9_3

		var_9_3:hideEquipNone()
		var_9_3:onUpdateMO(iter_9_1)
	end
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:_updatePresetItemList()
	arg_11_0:_initPrepareItemList()

	local var_11_0 = #V1a6_CachotRoleRecoverPrepareListModel.instance:getList()

	if var_11_0 <= 4 then
		arg_11_0._limitedScrollRect.enabled = false
		arg_11_0._contentSizeFitter.enabled = false

		recthelper.setWidth(arg_11_0._goleft.transform, 800)
		recthelper.setWidth(arg_11_0._goright.transform, 700)
	elseif var_11_0 <= 8 then
		arg_11_0._limitedScrollRect.enabled = false
		arg_11_0._gocontent.transform.anchorMin = Vector2.New(0.5, 0.5)
		arg_11_0._gocontent.transform.anchorMax = Vector2.New(0.5, 0.5)

		recthelper.setAnchorX(arg_11_0._gocontent.transform, -1206)
	else
		recthelper.setWidth(arg_11_0._goleft.transform, 720)

		local var_11_1 = arg_11_0._horizontal.padding

		var_11_1.right = 300
		arg_11_0._horizontal.padding = var_11_1
	end

	arg_11_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnClickTeamItem, arg_11_0._onClickTeamItem, arg_11_0)
	arg_11_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_11_0._onCloseView, arg_11_0)
end

function var_0_0._updatePresetItemList(arg_12_0)
	local var_12_0 = V1a6_CachotRoleRecoverPresetListModel.instance:getList()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._presetItemList) do
		local var_12_1 = var_12_0[iter_12_0]

		iter_12_1:onUpdateMO(var_12_1)
	end
end

function var_0_0._onCloseView(arg_13_0, arg_13_1)
	if arg_13_1 == ViewName.V1a6_CachotRoleRecoverResultView then
		arg_13_0:closeThis()
	end
end

function var_0_0._onClickTeamItem(arg_14_0, arg_14_1)
	arg_14_0._selectedMo = arg_14_1
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
