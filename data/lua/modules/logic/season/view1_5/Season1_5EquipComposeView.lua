module("modules.logic.season.view1_5.Season1_5EquipComposeView", package.seeall)

local var_0_0 = class("Season1_5EquipComposeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._scrollcardlist = gohelper.findChildScrollRect(arg_1_0.viewGO, "left/mask/#scroll_cardlist")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "left/#go_empty")
	arg_1_0._simagelight = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/composecontain/#simage_light")
	arg_1_0._gocard1 = gohelper.findChild(arg_1_0.viewGO, "right/composecontain/cards/#go_card1")
	arg_1_0._gocard2 = gohelper.findChild(arg_1_0.viewGO, "right/composecontain/cards/#go_card2")
	arg_1_0._gocard3 = gohelper.findChild(arg_1_0.viewGO, "right/composecontain/cards/#go_card3")
	arg_1_0._btncompose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_compose")
	arg_1_0._btndiscompose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_discompose")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncompose:AddClickListener(arg_2_0._btncomposeOnClick, arg_2_0)
	arg_2_0._btndiscompose:AddClickListener(arg_2_0._btndiscomposeOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncompose:RemoveClickListener()
	arg_3_0._btndiscompose:RemoveClickListener()
end

var_0_0.MaxUICount = 3

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg1:LoadImage(ResUrl.getSeasonIcon("full/hechengye_bj.jpg"))
	arg_4_0._simagelight:LoadImage(ResUrl.getSeasonIcon("hecheng_guang.png"))

	arg_4_0._txtHint = gohelper.findChildText(arg_4_0.viewGO, "right/tip")
	arg_4_0._matItems = {}
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0._simagebg1:UnLoadImage()

	for iter_5_0, iter_5_1 in pairs(arg_5_0._matItems) do
		gohelper.setActive(iter_5_1.goIcon, true)

		if iter_5_1.icon then
			iter_5_1.icon:disposeUI()
		end
	end

	Activity104EquipComposeController.instance:onCloseView()
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.actId

	Activity104EquipComposeController.instance:onOpenView(var_6_0)
	arg_6_0:addEventCb(Activity104EquipComposeController.instance, Activity104Event.OnComposeDataChanged, arg_6_0.handleComposeDataChanged, arg_6_0)
	arg_6_0:addEventCb(Activity104EquipComposeController.instance, Activity104Event.OnComposeSuccess, arg_6_0.handleComposeSucc, arg_6_0)
	arg_6_0:refreshUI()
end

function var_0_0.onClose(arg_7_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock(var_0_0.Compose_Anim_Block_Key)
	TaskDispatcher.cancelTask(arg_7_0.onPlayComposeAnimOver, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.delayRefreshView, arg_7_0)
end

function var_0_0.handleComposeSucc(arg_8_0)
	return
end

function var_0_0.handleComposeDataChanged(arg_9_0)
	if arg_9_0._delayRefreshUITime ~= nil and Time.time - arg_9_0._delayRefreshUITime < var_0_0.DelayRefreshTime then
		return
	end

	arg_9_0:refreshUI()
end

function var_0_0.refreshUI(arg_10_0)
	local var_10_0 = Activity104EquipItemComposeModel.instance:getList()

	gohelper.setActive(arg_10_0._goempty, not var_10_0 or #var_10_0 == 0)
	arg_10_0:refreshButtons()
	arg_10_0:refreshHint()
	arg_10_0:refreshMatList()
end

function var_0_0.refreshHint(arg_11_0)
	local var_11_0 = luaLang("season_compose_hint1")
	local var_11_1 = true

	if Activity104EquipItemComposeModel.instance:existSelectedMaterial() then
		local var_11_2 = Activity104EquipItemComposeModel.instance:getSelectedRare()

		if var_11_2 == Activity104Enum.Rare_Orange or var_11_2 == Activity104Enum.MainRoleRare then
			var_11_1 = false
		end
	end

	if not var_11_1 then
		var_11_0 = luaLang("season_compose_hint2")
	end

	arg_11_0._txtHint.text = var_11_0
end

function var_0_0.refreshMatList(arg_12_0)
	for iter_12_0 = 1, var_0_0.MaxUICount do
		arg_12_0:refreshMat(iter_12_0)
	end
end

function var_0_0.refreshButtons(arg_13_0)
	local var_13_0 = Activity104EquipItemComposeModel.instance:isMaterialAllReady()

	gohelper.setActive(arg_13_0._btncompose, var_13_0)
	gohelper.setActive(arg_13_0._btndiscompose, not var_13_0)
end

function var_0_0.refreshMat(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getOrCreateMatItem(arg_14_1)
	local var_14_1 = Activity104EquipItemComposeModel.instance.curSelectMap[arg_14_1]
	local var_14_2 = var_14_1 == Activity104EquipItemComposeModel.EmptyUid

	gohelper.setActive(var_14_0.goIcon, not var_14_2)
	gohelper.setActive(var_14_0.goEmpty, var_14_2)

	if not var_14_2 then
		arg_14_0:checkCreateMatItemIcon(var_14_0, arg_14_1)

		local var_14_3 = Activity104EquipItemComposeModel.instance:getEquipMO(var_14_1)

		var_14_0.icon:updateData(var_14_3.itemId)
	end
end

function var_0_0.getOrCreateMatItem(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._matItems[arg_15_1]

	if not var_15_0 then
		var_15_0 = arg_15_0:getUserDataTb_()
		var_15_0.go = gohelper.findChild(arg_15_0.viewGO, "right/composecontain/cards/#go_card" .. tostring(arg_15_1))
		var_15_0.goIcon = gohelper.findChild(var_15_0.go, "go_pos")
		var_15_0.goEmpty = gohelper.findChild(var_15_0.go, "go_empty")
		arg_15_0._matItems[arg_15_1] = var_15_0
	end

	return var_15_0
end

function var_0_0.checkCreateMatItemIcon(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_1.icon then
		local var_16_0 = arg_16_0.viewContainer:getSetting().otherRes[2]
		local var_16_1 = arg_16_0:getResInst(var_16_0, arg_16_1.goIcon, "icon" .. tostring(arg_16_2))

		arg_16_1.icon = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_1, Season1_5CelebrityCardEquip)

		arg_16_1.icon:setClickCall(arg_16_0.onClickMatSlot, arg_16_0, arg_16_2)
		gohelper.setAsFirstSibling(var_16_1)
	end
end

function var_0_0.onClickMatSlot(arg_17_0, arg_17_1)
	local var_17_0 = Activity104EquipItemComposeModel.instance.curSelectMap[arg_17_1]

	if not (var_17_0 == Activity104EquipItemComposeModel.EmptyUid) then
		Activity104EquipComposeController.instance:changeSelectCard(var_17_0)
	end
end

function var_0_0._btncomposeOnClick(arg_18_0)
	if Activity104EquipComposeController.instance:checkMaterialHasEquiped() then
		local function var_18_0()
			arg_18_0:playAnimBeforeSend()
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.SeasonComposeMatIsEquiped, MsgBoxEnum.BoxType.Yes_No, var_18_0)
	else
		arg_18_0:playAnimBeforeSend()
	end
end

function var_0_0._btndiscomposeOnClick(arg_20_0)
	GameFacade.showToast(ToastEnum.ClickSeasonDiscompose)
end

var_0_0.DelaySendTime = 1
var_0_0.DelayRefreshTime = 1
var_0_0.Compose_Anim_Block_Key = "Compose_Anim_Block"

function var_0_0.playAnimBeforeSend(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.onPlayComposeAnimOver, arg_21_0)
	arg_21_0.viewGO:GetComponent(typeof(UnityEngine.Animator)):Play("hecherng", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(var_0_0.Compose_Anim_Block_Key)
	TaskDispatcher.runDelay(arg_21_0.onPlayComposeAnimOver, arg_21_0, var_0_0.DelaySendTime)
end

function var_0_0.onPlayComposeAnimOver(arg_22_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock(var_0_0.Compose_Anim_Block_Key)
	Activity104EquipComposeController.instance:sendCompose()

	arg_22_0._delayRefreshUITime = Time.time

	TaskDispatcher.runDelay(arg_22_0.delayRefreshView, arg_22_0, var_0_0.DelayRefreshTime)
end

function var_0_0.delayRefreshView(arg_23_0)
	arg_23_0:refreshUI()
end

return var_0_0
