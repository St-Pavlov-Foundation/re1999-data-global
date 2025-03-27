module("modules.logic.playercard.view.comp.PlayerCardBaseInfoItem", package.seeall)

slot0 = class("PlayerCardBaseInfoItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gohero = gohelper.findChild(slot0.viewGO, "#go_role")
	slot0._txthero = gohelper.findChildText(slot0.viewGO, "#go_role/txt_role")
	slot0._txtheronum = gohelper.findChildText(slot0.viewGO, "#go_role/txt_role/#txt_num")
	slot0._goothers = gohelper.findChild(slot0.viewGO, "#go_others")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "select")
	slot0._txtbase = gohelper.findChildText(slot0.viewGO, "#go_others/#txt_base")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_others/layout/#txt_num")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#go_others/layout/#txt_dec")
	slot0._txtorder = gohelper.findChildText(slot0.viewGO, "select/#txt_order")
	slot0._goselecteffect = gohelper.findChild(slot0.viewGO, "select/#go_click")
	slot0._btnclick = gohelper.findChildButton(slot0.viewGO, "#btn_click")
	slot0._typeItemList = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1
	slot0.config = slot1.config
	slot0.playercardinfo = slot0.mo.info
	slot0.index = slot0.mo.index
	slot0.type = slot0.config.type

	slot0:refreshItem()

	slot2 = PlayerCardBaseInfoModel.instance:getSelectIndex(slot0.index)
	slot0._txtorder.text = tostring(slot2)

	if slot2 then
		gohelper.setActive(slot0._goselect, true)
	else
		gohelper.setActive(slot0._goselect, false)
		gohelper.setActive(slot0._goselecteffect, false)
	end
end

function slot0.refreshItem(slot0)
	if slot0.index == PlayerCardEnum.RightContent.HeroCount then
		slot0._isHeroNum = true
	else
		slot0._isHeroNum = false
	end

	gohelper.setActive(slot0._gohero, slot0._isHeroNum)
	gohelper.setActive(slot0._goothers, not slot0._isHeroNum)

	if slot0._isHeroNum then
		slot0._txthero.text = slot0.config.name
		slot0._txtheronum.text = slot0.playercardinfo:getHeroCount()
		slot0.chesslist = slot0:getUserDataTb_()
		slot0.chesslist = slot0.chesslist or {}

		if #slot0.chesslist <= 0 then
			for slot4 = 1, 5 do
				slot0.chesslist[slot4] = gohelper.findChildImage(slot0._gohero, "collection/collection" .. slot4 .. "/#image_full")
			end
		end

		slot1, slot2, slot3, slot4, slot5 = slot0.playercardinfo:getHeroRarePercent()
		slot0.chesslist[1].fillAmount = slot1 or 100
		slot0.chesslist[2].fillAmount = slot2 or 100
		slot0.chesslist[3].fillAmount = slot3 or 100
		slot0.chesslist[4].fillAmount = slot4 or 100
		slot0.chesslist[5].fillAmount = slot5 or 100
	else
		slot0._txtbase.text = slot0.config.name
		slot0._txtnum.text, slot2 = slot0.playercardinfo:getBaseInfoByIndex(slot0.index, true)
		slot0._txtdesc.text = slot2 or ""
	end
end

function slot0._btnclickOnClick(slot0)
	if slot0.index == PlayerCardEnum.RightContent.HeroCount then
		GameFacade.showToast(ToastEnum.PlayerCardCanotClick)

		return
	end

	PlayerCardBaseInfoModel.instance:clickItem(slot0.index)
	gohelper.setActive(slot0._goselecteffect, true)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
