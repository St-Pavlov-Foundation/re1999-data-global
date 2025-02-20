module("modules.logic.battlepass.view.BpBonusSelectView", package.seeall)

slot0 = class("BpBonusSelectView", BaseView)
slot1 = {
	Finish = 3,
	CanGet = 2,
	Lock = 1
}

function slot0.onInitView(slot0)
	slot0._goselect = gohelper.findChild(slot0.viewGO, "txt_titledec")
	slot0._btnGet = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_get")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#go_lock")
	slot0._finish = gohelper.findChild(slot0.viewGO, "#go_finish")
	slot4 = "#go_finish/#txt_getname"
	slot0._txtgetname = gohelper.findChildTextMesh(slot0.viewGO, slot4)
	slot0._items = {}

	for slot4 = 1, 4 do
		slot5 = gohelper.findChild(slot0.viewGO, "item" .. slot4)
		slot0._items[slot4] = slot0:getUserDataTb_()
		slot0._items[slot4].select = gohelper.findChild(slot5, "#go_select")
		slot0._items[slot4].btnClick = gohelper.findChildButtonWithAudio(slot5, "#btn_click")
		slot0._items[slot4].btnDetail = gohelper.findChildButtonWithAudio(slot5, "#btn_detail")
		slot0._items[slot4].imageSign = gohelper.findChildSingleImage(slot5, "#simage_sign")
		slot0._items[slot4].mask = gohelper.findChild(slot5, "#go_mask")
		slot0._items[slot4].owned = gohelper.findChild(slot5, "#go_owned")
		slot0._items[slot4].get = gohelper.findChild(slot5, "#go_get")
		slot0._items[slot4].getAnim = slot0._items[slot4].get:GetComponent(typeof(UnityEngine.Animator))

		if slot4 == 4 then
			slot0._items[slot4].txtname = gohelper.findChildTextMesh(slot5, "#txt_name")
		else
			slot0._items[slot4].txtskinname = gohelper.findChildTextMesh(slot5, "#txt_skinname")
			slot0._items[slot4].txtname = gohelper.findChildTextMesh(slot5, "#txt_skinname/#txt_name")
		end

		slot0:addClickCb(slot0._items[slot4].btnClick, slot0._onGetClick, slot0, slot4)
		slot0:addClickCb(slot0._items[slot4].btnDetail, slot0._onDetailClick, slot0, slot4)
	end

	slot0:addClickCb(slot0._btnGet, slot0._getBonus, slot0)
	slot0:addClickCb(slot0._btnClose, slot0.closeThis, slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2BPSP.play_ui_mln_unlock)

	slot2 = nil

	for slot6, slot7 in ipairs(BpConfig.instance:getBonusCOList(BpModel.instance.id)) do
		if not string.nilorempty(slot7.selfSelectPayBonus) then
			slot2 = slot7

			break
		end
	end

	if not slot2 then
		logError("没有皮肤可选！！！")

		return
	end

	slot0._itemInfo = GameUtil.splitString2(slot2.selfSelectPayBonus, true)
	slot0._level = slot2.level
	slot0._getIndex = BpBonusModel.instance:isGetSelectBonus(slot0._level)

	if BpModel.instance.firstShowSp or BpModel.instance:getBpLv() < slot0._level then
		slot0._statu = uv0.Lock

		slot0:setFinish(0)
	elseif slot0._getIndex then
		slot0._statu = uv0.Finish

		slot0:setFinish(slot0._getIndex)
	else
		slot0._statu = uv0.CanGet

		slot0:setFinish(0)
	end

	slot0:setSelect(0)
	gohelper.setActive(slot0._btnGet, slot0._statu == uv0.CanGet)
	gohelper.setActive(slot0._golock, slot0._statu == uv0.Lock)
	gohelper.setActive(slot0._finish, slot0._statu == uv0.Finish)
	gohelper.setActive(slot0._goselect, slot0._statu ~= uv0.Finish)
	ZProj.UGUIHelper.SetGrayFactor(slot0._btnGet.gameObject, 1)

	for slot7 = 1, 4 do
		gohelper.setActive(slot0._items[slot7].owned, ItemModel.instance:getItemQuantity(slot0._itemInfo[slot7][1], slot0._itemInfo[slot7][2]) > 0)

		if slot0._statu == uv0.Finish then
			gohelper.setActive(slot0._items[slot7].mask, slot0._getIndex ~= slot7)

			if slot0._getIndex == slot7 then
				gohelper.setActive(slot0._items[slot7].owned, false)
			end
		else
			gohelper.setActive(slot0._items[slot7].mask, slot8)
		end

		slot9 = ItemConfig.instance:getItemConfig(slot0._itemInfo[slot7][1], slot0._itemInfo[slot7][2])
		slot10 = ""

		if slot7 == 4 then
			slot0._items[slot7].txtname.text = slot9.name
			slot10 = slot9.name
		else
			slot0._items[slot7].txtskinname.text = slot9.des
			slot11 = HeroConfig.instance:getHeroCO(slot9.characterId)
			slot0._items[slot7].txtname.text = slot11.name
			slot10 = string.format("%s——%s", slot11.name, slot9.des)
		end

		if slot0._getIndex == slot7 then
			slot0._txtgetname.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("bp_sp_get_bound"), slot10)
		end
	end
end

function slot0.setSelect(slot0, slot1)
	for slot5 = 1, 4 do
		gohelper.setActive(slot0._items[slot5].select, slot1 == slot5)
	end
end

function slot0.setFinish(slot0, slot1)
	for slot5 = 1, 4 do
		gohelper.setActive(slot0._items[slot5].get, slot1 == slot5)

		if slot1 == slot5 then
			slot0._items[slot5].getAnim:Play("in")
		end
	end
end

function slot0._onGetClick(slot0, slot1)
	if slot0._statu == uv0.CanGet then
		if slot0._items[slot1].mask.activeSelf then
			return
		end

		ZProj.UGUIHelper.SetGrayFactor(slot0._btnGet.gameObject, 0)

		slot0._nowSelect = slot1

		slot0:setSelect(slot1)
	else
		slot0:_onDetailClick(slot1)
	end
end

function slot0._getBonus(slot0)
	if not slot0._nowSelect then
		return
	end

	BpRpc.instance:sendGetSelfSelectBonusRequest(slot0._level or 0, slot0._nowSelect - 1)
	slot0:closeThis()
end

function slot0._onDetailClick(slot0, slot1)
	if not slot0._itemInfo[slot1] then
		return
	end

	MaterialTipController.instance:showMaterialInfo(slot0._itemInfo[slot1][1], slot0._itemInfo[slot1][2], false, nil, false)
end

return slot0
