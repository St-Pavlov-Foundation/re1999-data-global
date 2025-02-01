module("modules.logic.season.view1_6.Season1_6EquipComposeView", package.seeall)

slot0 = class("Season1_6EquipComposeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg1")
	slot0._scrollcardlist = gohelper.findChildScrollRect(slot0.viewGO, "left/mask/#scroll_cardlist")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "left/#go_empty")
	slot0._simagelight = gohelper.findChildSingleImage(slot0.viewGO, "right/composecontain/#simage_light")
	slot0._gocard1 = gohelper.findChild(slot0.viewGO, "right/composecontain/cards/#go_card1")
	slot0._gocard2 = gohelper.findChild(slot0.viewGO, "right/composecontain/cards/#go_card2")
	slot0._gocard3 = gohelper.findChild(slot0.viewGO, "right/composecontain/cards/#go_card3")
	slot0._btncompose = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_compose")
	slot0._btndiscompose = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_discompose")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncompose:AddClickListener(slot0._btncomposeOnClick, slot0)
	slot0._btndiscompose:AddClickListener(slot0._btndiscomposeOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncompose:RemoveClickListener()
	slot0._btndiscompose:RemoveClickListener()
end

slot0.MaxUICount = 3

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getSeasonIcon("full/hechengye_bj.jpg"))
	slot0._simagelight:LoadImage(ResUrl.getSeasonIcon("hecheng_guang.png"))

	slot0._txtHint = gohelper.findChildText(slot0.viewGO, "right/tip")
	slot0._matItems = {}
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()

	for slot4, slot5 in pairs(slot0._matItems) do
		gohelper.setActive(slot5.goIcon, true)

		if slot5.icon then
			slot5.icon:disposeUI()
		end
	end

	Activity104EquipComposeController.instance:onCloseView()
end

function slot0.onOpen(slot0)
	Activity104EquipComposeController.instance:onOpenView(slot0.viewParam.actId)
	slot0:addEventCb(Activity104EquipComposeController.instance, Activity104Event.OnComposeDataChanged, slot0.handleComposeDataChanged, slot0)
	slot0:addEventCb(Activity104EquipComposeController.instance, Activity104Event.OnComposeSuccess, slot0.handleComposeSucc, slot0)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock(uv0.Compose_Anim_Block_Key)
	TaskDispatcher.cancelTask(slot0.onPlayComposeAnimOver, slot0)
	TaskDispatcher.cancelTask(slot0.delayRefreshView, slot0)
end

function slot0.handleComposeSucc(slot0)
end

function slot0.handleComposeDataChanged(slot0)
	if slot0._delayRefreshUITime ~= nil and Time.time - slot0._delayRefreshUITime < uv0.DelayRefreshTime then
		return
	end

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._goempty, not Activity104EquipItemComposeModel.instance:getList() or #slot1 == 0)
	slot0:refreshButtons()
	slot0:refreshHint()
	slot0:refreshMatList()
end

function slot0.refreshHint(slot0)
	slot1 = luaLang("season_compose_hint1")
	slot2 = true

	if Activity104EquipItemComposeModel.instance:existSelectedMaterial() and (Activity104EquipItemComposeModel.instance:getSelectedRare() == Activity104Enum.Rare_Orange or slot3 == Activity104Enum.MainRoleRare) then
		slot2 = false
	end

	if not slot2 then
		slot1 = luaLang("season_compose_hint2")
	end

	slot0._txtHint.text = slot1
end

function slot0.refreshMatList(slot0)
	for slot4 = 1, uv0.MaxUICount do
		slot0:refreshMat(slot4)
	end
end

function slot0.refreshButtons(slot0)
	slot1 = Activity104EquipItemComposeModel.instance:isMaterialAllReady()

	gohelper.setActive(slot0._btncompose, slot1)
	gohelper.setActive(slot0._btndiscompose, not slot1)
end

function slot0.refreshMat(slot0, slot1)
	slot2 = slot0:getOrCreateMatItem(slot1)
	slot4 = Activity104EquipItemComposeModel.instance.curSelectMap[slot1] == Activity104EquipItemComposeModel.EmptyUid

	gohelper.setActive(slot2.goIcon, not slot4)
	gohelper.setActive(slot2.goEmpty, slot4)

	if not slot4 then
		slot0:checkCreateMatItemIcon(slot2, slot1)
		slot2.icon:updateData(Activity104EquipItemComposeModel.instance:getEquipMO(slot3).itemId)
	end
end

function slot0.getOrCreateMatItem(slot0, slot1)
	if not slot0._matItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.findChild(slot0.viewGO, "right/composecontain/cards/#go_card" .. tostring(slot1))
		slot2.goIcon = gohelper.findChild(slot2.go, "go_pos")
		slot2.goEmpty = gohelper.findChild(slot2.go, "go_empty")
		slot0._matItems[slot1] = slot2
	end

	return slot2
end

function slot0.checkCreateMatItemIcon(slot0, slot1, slot2)
	if not slot1.icon then
		slot4 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot1.goIcon, "icon" .. tostring(slot2))
		slot1.icon = MonoHelper.addNoUpdateLuaComOnceToGo(slot4, Season1_6CelebrityCardEquip)

		slot1.icon:setClickCall(slot0.onClickMatSlot, slot0, slot2)
		gohelper.setAsFirstSibling(slot4)
	end
end

function slot0.onClickMatSlot(slot0, slot1)
	if not (Activity104EquipItemComposeModel.instance.curSelectMap[slot1] == Activity104EquipItemComposeModel.EmptyUid) then
		Activity104EquipComposeController.instance:changeSelectCard(slot2)
	end
end

function slot0._btncomposeOnClick(slot0)
	if Activity104EquipComposeController.instance:checkMaterialHasEquiped() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SeasonComposeMatIsEquiped, MsgBoxEnum.BoxType.Yes_No, function ()
			uv0:playAnimBeforeSend()
		end)
	else
		slot0:playAnimBeforeSend()
	end
end

function slot0._btndiscomposeOnClick(slot0)
	GameFacade.showToast(ToastEnum.ClickSeasonDiscompose)
end

slot0.DelaySendTime = 1
slot0.DelayRefreshTime = 1
slot0.Compose_Anim_Block_Key = "Compose_Anim_Block"

function slot0.playAnimBeforeSend(slot0)
	TaskDispatcher.cancelTask(slot0.onPlayComposeAnimOver, slot0)
	slot0.viewGO:GetComponent(typeof(UnityEngine.Animator)):Play("hecherng", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(uv0.Compose_Anim_Block_Key)
	TaskDispatcher.runDelay(slot0.onPlayComposeAnimOver, slot0, uv0.DelaySendTime)
end

function slot0.onPlayComposeAnimOver(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock(uv0.Compose_Anim_Block_Key)
	Activity104EquipComposeController.instance:sendCompose()

	slot0._delayRefreshUITime = Time.time

	TaskDispatcher.runDelay(slot0.delayRefreshView, slot0, uv0.DelayRefreshTime)
end

function slot0.delayRefreshView(slot0)
	slot0:refreshUI()
end

return slot0
