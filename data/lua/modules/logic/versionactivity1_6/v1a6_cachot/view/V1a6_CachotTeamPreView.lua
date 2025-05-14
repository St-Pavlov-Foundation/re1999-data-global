module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamPreView", package.seeall)

local var_0_0 = class("V1a6_CachotTeamPreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_view")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_left")
	arg_1_0._simageselect = gohelper.findChildSingleImage(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_left/#simage_select")
	arg_1_0._gopresetcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_left/scroll_view/Viewport/#go_presetcontent")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_right")
	arg_1_0._gopreparecontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_right/scroll_view/Viewport/#go_preparecontent")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._contentSizeFitter = arg_5_0._gocontent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
	arg_5_0._horizontal = arg_5_0._gocontent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	arg_5_0._limitedScrollRect = arg_5_0._scrollview:GetComponent(typeof(ZProj.LimitedScrollRect))

	arg_5_0:_initPresetItemList()
end

function var_0_0._initPresetItemList(arg_6_0)
	if arg_6_0._presetItemList then
		return
	end

	arg_6_0._presetItemList = arg_6_0:getUserDataTb_()

	local var_6_0 = arg_6_0.viewContainer:getSetting().otherRes[1]

	for iter_6_0 = 1, V1a6_CachotEnum.HeroCountInGroup do
		local var_6_1 = arg_6_0:getResInst(var_6_0, arg_6_0._gopresetcontent, "item" .. tostring(iter_6_0))
		local var_6_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_1, V1a6_CachotTeamPreviewPresetItem)

		arg_6_0._presetItemList[iter_6_0] = var_6_2
	end
end

function var_0_0._initPrepareItemList(arg_7_0)
	if arg_7_0._prepareItemList then
		return
	end

	arg_7_0._prepareItemList = arg_7_0:getUserDataTb_()

	local var_7_0 = arg_7_0.viewContainer:getSetting().otherRes[2]
	local var_7_1 = V1a6_CachotTeamPreviewPrepareListModel.instance:getList()

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_2 = arg_7_0:getResInst(var_7_0, arg_7_0._gopreparecontent, "item" .. tostring(iter_7_0))
		local var_7_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_2, V1a6_CachotTeamPreviewPrepareItem)

		arg_7_0._prepareItemList[iter_7_0] = var_7_3

		var_7_3:hideEquipNone()
		var_7_3:onUpdateMO(iter_7_1)
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	V1a6_CachotTeamModel.instance:clearSeatInfos()
	V1a6_CachotTeamPreviewPrepareListModel.instance:initList()
	arg_9_0:_updatePresetItemList()
	arg_9_0:_initPrepareItemList()

	local var_9_0 = #V1a6_CachotTeamPreviewPrepareListModel.instance:getList()

	if var_9_0 <= 4 then
		arg_9_0._limitedScrollRect.enabled = false
		arg_9_0._contentSizeFitter.enabled = false

		recthelper.setWidth(arg_9_0._goleft.transform, 800)
		recthelper.setWidth(arg_9_0._goright.transform, 700)
	elseif var_9_0 <= 8 then
		arg_9_0._limitedScrollRect.enabled = false
		arg_9_0._gocontent.transform.anchorMin = Vector2.New(0.5, 0.5)
		arg_9_0._gocontent.transform.anchorMax = Vector2.New(0.5, 0.5)

		recthelper.setAnchorX(arg_9_0._gocontent.transform, -1206)
	else
		recthelper.setWidth(arg_9_0._goleft.transform, 720)

		local var_9_1 = arg_9_0._horizontal.padding

		var_9_1.right = 300
		arg_9_0._horizontal.padding = var_9_1
	end
end

function var_0_0._updatePresetItemList(arg_10_0)
	local var_10_0 = V1a6_CachotTeamPreviewPresetListModel.instance:initList()

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._presetItemList) do
		local var_10_1 = var_10_0[iter_10_0]

		iter_10_1:onUpdateMO(var_10_1)
	end
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
