module("modules.logic.player.view.IconTipView", package.seeall)

local var_0_0 = class("IconTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagetop = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/bg/#simage_top")
	arg_1_0._simagebottom = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/bg/#simage_bottom")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "window/right/useState/#btn_change")
	arg_1_0._txtnameCn = gohelper.findChildText(arg_1_0.viewGO, "window/right/#txt_nameCn")
	arg_1_0._gousing = gohelper.findChild(arg_1_0.viewGO, "window/right/useState/#go_using")
	arg_1_0._simageheadIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/right/#simage_headIcon")
	arg_1_0._goframenode = gohelper.findChild(arg_1_0.viewGO, "window/right/#simage_headIcon/#go_framenode")
	arg_1_0._btncloseBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "window/top/#btn_closeBtn")
	arg_1_0._loader = MultiAbLoader.New()

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncloseBtn:AddClickListener(arg_2_0._btncloseBtnOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncloseBtn:RemoveClickListener()
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	local var_4_0 = IconTipModel.instance:getSelectIcon()

	PlayerRpc.instance:sendSetPortraitRequest(var_4_0)
end

function var_0_0._btncloseBtnOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	local var_6_0 = PlayerModel.instance:getPlayinfo()

	IconTipModel.instance:setSelectIcon(var_6_0.portrait)
	IconTipModel.instance:setIconList(var_6_0.portrait)
	arg_6_0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	arg_6_0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))

	arg_6_0._buttonbg = gohelper.findChildClick(arg_6_0.viewGO, "maskbg")

	arg_6_0._buttonbg:AddClickListener(arg_6_0._btncloseBtnOnClick, arg_6_0)
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:_refreshUI()
end

function var_0_0._refreshUI(arg_8_0)
	local var_8_0 = IconTipModel.instance:getSelectIcon()
	local var_8_1 = PlayerModel.instance:getPlayinfo().portrait

	gohelper.setActive(arg_8_0._btnconfirm.gameObject, var_8_0 ~= var_8_1)
	gohelper.setActive(arg_8_0._gousing, var_8_0 == var_8_1)

	local var_8_2 = lua_item.configDict[var_8_0]

	arg_8_0._txtnameCn.text = var_8_2.name

	if not arg_8_0._liveHeadIcon then
		arg_8_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_8_0._simageheadIcon)
	end

	arg_8_0._liveHeadIcon:setLiveHead(var_8_2.id)

	local var_8_3 = string.split(var_8_2.effect, "#")

	if #var_8_3 > 1 then
		if var_8_2.id == tonumber(var_8_3[#var_8_3]) then
			gohelper.setActive(arg_8_0._goframenode, true)

			if not arg_8_0.frame then
				local var_8_4 = "ui/viewres/common/effect/frame.prefab"

				arg_8_0._loader:addPath(var_8_4)
				arg_8_0._loader:startLoad(arg_8_0._onLoadCallback, arg_8_0)
			end
		end
	else
		gohelper.setActive(arg_8_0._goframenode, false)
	end
end

function var_0_0._onLoadCallback(arg_9_0)
	local var_9_0 = arg_9_0._loader:getFirstAssetItem():GetResource()

	gohelper.clone(var_9_0, arg_9_0._goframenode, "frame")

	arg_9_0.frame = gohelper.findChild(arg_9_0._goframenode, "frame")
	arg_9_0.frame:GetComponent(gohelper.Type_Image).enabled = false

	local var_9_1 = 1.41 * (recthelper.getWidth(arg_9_0._simageheadIcon.transform) / recthelper.getWidth(arg_9_0.frame.transform))

	transformhelper.setLocalScale(arg_9_0.frame.transform, var_9_1, var_9_1, 1)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addEventCb(PlayerController.instance, PlayerEvent.SelectPortrait, arg_10_0._refreshUI, arg_10_0)
	arg_10_0:addEventCb(PlayerController.instance, PlayerEvent.SetPortrait, arg_10_0._refreshUI, arg_10_0)
	arg_10_0:_refreshUI()
end

function var_0_0.onClose(arg_11_0)
	arg_11_0:removeEventCb(PlayerController.instance, PlayerEvent.SelectPortrait, arg_11_0._refreshUI, arg_11_0)
	arg_11_0:removeEventCb(PlayerController.instance, PlayerEvent.SetPortrait, arg_11_0._refreshUI, arg_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simageheadIcon:UnLoadImage()
	arg_12_0._buttonbg:RemoveClickListener()

	if arg_12_0._loader then
		arg_12_0._loader:dispose()

		arg_12_0._loader = nil
	end
end

return var_0_0
