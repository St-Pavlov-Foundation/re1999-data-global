module("modules.logic.player.view.IconTipView", package.seeall)

local var_0_0 = class("IconTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagetop = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/bg/#simage_top")
	arg_1_0._simagebottom = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/bg/#simage_bottom")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "window/right/useState/#btn_change")
	arg_1_0._txtnameCn = gohelper.findChildText(arg_1_0.viewGO, "window/right/#txt_nameCn")
	arg_1_0._gousing = gohelper.findChild(arg_1_0.viewGO, "window/right/useState/#go_using")
	arg_1_0._simageheadIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/right/#simage_headIcon")
	arg_1_0._gomainsignature = gohelper.findChild(arg_1_0.viewGO, "window/right/signname")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/right/signname2")
	arg_1_0._goframenode = gohelper.findChild(arg_1_0.viewGO, "window/right/#simage_headIcon/#go_framenode")
	arg_1_0._btncloseBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "window/top/#btn_closeBtn")
	arg_1_0._btnSwitchLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "window/right/Btn_SwitchLeft")
	arg_1_0._btnSwitchRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "window/right/Btn_SwitchRight")
	arg_1_0._loader = MultiAbLoader.New()

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncloseBtn:AddClickListener(arg_2_0._btncloseBtnOnClick, arg_2_0)
	arg_2_0._btnSwitchLeft:AddClickListener(arg_2_0._btnSwitchBtnOnClick, arg_2_0, false)
	arg_2_0._btnSwitchRight:AddClickListener(arg_2_0._btnSwitchBtnOnClick, arg_2_0, true)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncloseBtn:RemoveClickListener()
	arg_3_0._btnSwitchLeft:RemoveClickListener()
	arg_3_0._btnSwitchRight:RemoveClickListener()
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	local var_4_0

	if arg_4_0._curSwitchIndex and arg_4_0._switchHeadIdList then
		var_4_0 = arg_4_0._switchHeadIdList[arg_4_0._curSwitchIndex]

		if var_4_0 == nil then
			logError("不存在的镀层头像索引")

			return
		end
	else
		var_4_0 = IconTipModel.instance:getSelectIcon()
	end

	PlayerRpc.instance:sendSetPortraitRequest(var_4_0)
end

function var_0_0._btncloseBtnOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnSwitchBtnOnClick(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._curSwitchIndex

	if arg_6_1 then
		var_6_0 = math.min(var_6_0 + 1, arg_6_0._switchHeadIdCount)
	else
		var_6_0 = math.max(var_6_0 - 1, 1)
	end

	local var_6_1 = arg_6_0._switchHeadIdList[var_6_0]

	if var_6_1 == nil then
		logError("index outof range")

		return
	end

	IconTipModel.instance:setSelectIcon(var_6_1)
	arg_6_0:_refreshSwitchBtnState(var_6_0)

	local var_6_2 = lua_item.configDict[var_6_1]

	arg_6_0:_setHeadIcon(var_6_2)
end

function var_0_0._editableInitView(arg_7_0)
	local var_7_0 = PlayerModel.instance:getPlayinfo()

	IconTipModel.instance:setSelectIcon(var_7_0.portrait)
	IconTipModel.instance:setIconList(var_7_0.portrait)
	arg_7_0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	arg_7_0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))

	arg_7_0._buttonbg = gohelper.findChildClick(arg_7_0.viewGO, "maskbg")

	arg_7_0._buttonbg:AddClickListener(arg_7_0._btncloseBtnOnClick, arg_7_0)
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:_refreshUI()
end

function var_0_0._refreshUI(arg_9_0)
	local var_9_0 = IconTipModel.instance:getSelectIcon()
	local var_9_1 = PlayerModel.instance:getPlayinfo().portrait

	arg_9_0._usedIcon = var_9_1

	gohelper.setActive(arg_9_0._btnconfirm.gameObject, var_9_0 ~= var_9_1)
	gohelper.setActive(arg_9_0._gousing, var_9_0 == var_9_1)

	local var_9_2 = lua_item.configDict[var_9_0]

	arg_9_0._txtnameCn.text = var_9_2.name

	arg_9_0:_setHeadIcon(var_9_2)
	gohelper.setActive(arg_9_0._btnSwitchLeft.gameObject, false)
	gohelper.setActive(arg_9_0._btnSwitchRight.gameObject, false)

	arg_9_0._curSwitchIndex = nil
	arg_9_0._switchHeadIdList = nil
	arg_9_0._switchHeadIdCount = nil

	if string.nilorempty(var_9_2.effect) then
		return
	end

	local var_9_3 = string.splitToNumber(var_9_2.effect, "#")

	if var_9_3 == nil then
		return
	end

	if #var_9_3 <= 0 then
		return
	end

	arg_9_0._switchHeadIdCount = 0
	arg_9_0._switchHeadIdList = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_3) do
		if ItemModel.instance:getById(iter_9_1) ~= nil then
			table.insert(arg_9_0._switchHeadIdList, iter_9_1)

			arg_9_0._switchHeadIdCount = arg_9_0._switchHeadIdCount + 1
		end
	end

	if arg_9_0._switchHeadIdCount <= 0 then
		return
	end

	local var_9_4

	for iter_9_2, iter_9_3 in ipairs(arg_9_0._switchHeadIdList) do
		if iter_9_3 == var_9_0 then
			var_9_4 = iter_9_2
		end
	end

	if var_9_4 == nil then
		logError("没有找到编号为 ：" .. var_9_0 .. "的镀层头像")

		return
	end

	arg_9_0:_refreshSwitchBtnState(var_9_4)
end

function var_0_0._setHeadIcon(arg_10_0, arg_10_1)
	if arg_10_1 == nil then
		logError("头像为空")

		return
	end

	if not arg_10_0._liveHeadIcon then
		arg_10_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_10_0._simageheadIcon)
	end

	arg_10_0._liveHeadIcon:setLiveHead(arg_10_1.id)

	local var_10_0 = "qianming"

	if arg_10_1.headIconSign and not string.nilorempty(arg_10_1.headIconSign) then
		local var_10_1 = arg_10_1.headIconSign

		gohelper.setActive(arg_10_0._gomainsignature, false)
		gohelper.setActive(arg_10_0._simagesignature.gameObject, true)
		arg_10_0._simagesignature:LoadImage(ResUrl.getSignature(var_10_1, "rolehead"), arg_10_0._onSignatureImageLoad, arg_10_0)
	else
		gohelper.setActive(arg_10_0._gomainsignature, true)
		gohelper.setActive(arg_10_0._simagesignature.gameObject, false)
	end

	local var_10_2 = string.split(arg_10_1.effect, "#")

	if #var_10_2 > 1 then
		if arg_10_1.id == tonumber(var_10_2[#var_10_2]) then
			gohelper.setActive(arg_10_0._goframenode, true)

			if not arg_10_0.frame then
				local var_10_3 = "ui/viewres/common/effect/frame.prefab"

				arg_10_0._loader:addPath(var_10_3)
				arg_10_0._loader:startLoad(arg_10_0._onLoadCallback, arg_10_0)
			end
		end
	else
		gohelper.setActive(arg_10_0._goframenode, false)
	end
end

function var_0_0._onSignatureImageLoad(arg_11_0)
	ZProj.UGUIHelper.SetImageSize(arg_11_0._simagesignature.gameObject)
end

function var_0_0._refreshSwitchBtnState(arg_12_0, arg_12_1)
	arg_12_0._curSwitchIndex = arg_12_1

	local var_12_0 = arg_12_0._switchHeadIdList[arg_12_1]

	gohelper.setActive(arg_12_0._btnSwitchLeft.gameObject, arg_12_1 > 1)
	gohelper.setActive(arg_12_0._btnSwitchRight.gameObject, arg_12_1 < arg_12_0._switchHeadIdCount)
	gohelper.setActive(arg_12_0._btnconfirm, var_12_0 ~= arg_12_0._usedIcon)
end

function var_0_0._onLoadCallback(arg_13_0)
	local var_13_0 = arg_13_0._loader:getFirstAssetItem():GetResource()

	gohelper.clone(var_13_0, arg_13_0._goframenode, "frame")

	arg_13_0.frame = gohelper.findChild(arg_13_0._goframenode, "frame")
	arg_13_0.frame:GetComponent(gohelper.Type_Image).enabled = false

	local var_13_1 = 1.41 * (recthelper.getWidth(arg_13_0._simageheadIcon.transform) / recthelper.getWidth(arg_13_0.frame.transform))

	transformhelper.setLocalScale(arg_13_0.frame.transform, var_13_1, var_13_1, 1)
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:addEventCb(PlayerController.instance, PlayerEvent.SelectPortrait, arg_14_0._refreshUI, arg_14_0)
	arg_14_0:addEventCb(PlayerController.instance, PlayerEvent.SetPortrait, arg_14_0._refreshUI, arg_14_0)
	arg_14_0:_refreshUI()
end

function var_0_0.onClose(arg_15_0)
	arg_15_0:removeEventCb(PlayerController.instance, PlayerEvent.SelectPortrait, arg_15_0._refreshUI, arg_15_0)
	arg_15_0:removeEventCb(PlayerController.instance, PlayerEvent.SetPortrait, arg_15_0._refreshUI, arg_15_0)
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0._simageheadIcon:UnLoadImage()
	arg_16_0._buttonbg:RemoveClickListener()

	if arg_16_0._loader then
		arg_16_0._loader:dispose()

		arg_16_0._loader = nil
	end
end

return var_0_0
