module("modules.logic.player.view.IconListItem", package.seeall)

local var_0_0 = class("IconListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageheadIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_headIcon")
	arg_1_0._goframenode = gohelper.findChild(arg_1_0.viewGO, "#simage_headIcon/#go_framenode")
	arg_1_0._gochoosing = gohelper.findChild(arg_1_0.viewGO, "#go_choosing")
	arg_1_0._goblackShadow = gohelper.findChild(arg_1_0.viewGO, "#go_blackShadow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._portraitclick:AddClickListener(arg_2_0._selectPortrait, arg_2_0)
	arg_2_0:addEventCb(PlayerController.instance, PlayerEvent.SelectPortrait, arg_2_0._onSelectPortrait, arg_2_0)
	arg_2_0:addEventCb(PlayerController.instance, PlayerEvent.SetPortrait, arg_2_0._onSetPortrait, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._portraitclick:RemoveClickListener()
	arg_3_0:removeEventCb(PlayerController.instance, PlayerEvent.SelectPortrait, arg_3_0._onSelectPortrait, arg_3_0)
	arg_3_0:removeEventCb(PlayerController.instance, PlayerEvent.SetPortrait, arg_3_0._onSetPortrait, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._goportrait = gohelper.findChild(arg_4_0.viewGO, "#simage_headIcon")
	arg_4_0._portraitclick = SLFramework.UGUI.UIClickListener.Get(arg_4_0._goportrait)
end

function var_0_0._editableRemoveEvents(arg_5_0)
	return
end

function var_0_0._selectPortrait(arg_6_0)
	IconTipModel.instance:setSelectIcon(arg_6_0._usePortrait)
end

function var_0_0._onSelectPortrait(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._usePortrait == arg_7_1 or arg_7_0._mo.effectPortraitDic[arg_7_1]

	gohelper.setActive(arg_7_0._gochoosing, var_7_0)
end

function var_0_0._onSetPortrait(arg_8_0, arg_8_1)
	if arg_8_0._mo.effectPortraitDic and arg_8_0._mo.effectPortraitDic[arg_8_1] then
		arg_8_0:_refreshUI()
	end
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._mo = arg_9_1

	arg_9_0:_refreshUI()
end

function var_0_0._refreshUI(arg_10_0)
	local var_10_0 = arg_10_0._mo

	if not arg_10_0._liveHeadIcon then
		arg_10_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_10_0._simageheadIcon)
	end

	local var_10_1 = PlayerModel.instance:getPlayinfo().portrait
	local var_10_2

	if var_10_0.effectPortraitDic and var_10_0.effectPortraitDic[var_10_1] then
		var_10_2 = var_10_1
	else
		var_10_2 = var_10_0.id
	end

	arg_10_0._usePortrait = var_10_2

	arg_10_0._liveHeadIcon:setLiveHead(var_10_2)

	local var_10_3 = IconTipModel.instance:getSelectIcon()

	gohelper.setActive(arg_10_0._gochoosing, var_10_2 == var_10_3)
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simageheadIcon:UnLoadImage()
end

return var_0_0
