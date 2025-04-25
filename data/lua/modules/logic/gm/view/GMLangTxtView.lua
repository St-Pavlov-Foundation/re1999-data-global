module("modules.logic.gm.view.GMLangTxtView", package.seeall)

slot0 = class("GMLangTxtView", BaseView)
slot1 = 1
slot2 = 2
slot3 = 3

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/btnClose")
	slot0._btnShow = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/btnShow")
	slot0._btnHide = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/btnHide")
	slot0._btnDelete = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/title/btnDelete")
	slot0._rect = gohelper.findChild(slot0.viewGO, "view").transform
	slot0._inputSearch = gohelper.findChildTextMeshInputField(slot0.viewGO, "view/title/InputField")
	slot0._dropLangChange = gohelper.findChildDropdown(slot0.viewGO, "view/title/dropdown_lang")
	slot0._goLangItemList = {}
	slot0.supportLangs = {}

	for slot7 = 0, GameConfig:GetSupportedLangs().Length - 1 do
		table.insert(slot0.supportLangs, LangSettings.shortcutTab[slot2[slot7]])

		slot8 = GMLangTxtLangItem.New()

		slot8:init(gohelper.cloneInPlace(gohelper.findChild(slot0.viewGO, "view/right/scroll/Viewport/content/item"), "item"), LangSettings.shortcutTab[slot2[slot7]])
		table.insert(slot0._goLangItemList, slot8)
	end

	slot0._dropLangChange:ClearOptions()
	slot0._dropLangChange:AddOptions(slot0.supportLangs)

	for slot8 = 1, #slot0.supportLangs do
		if slot0.supportLangs[slot8] == LangSettings.instance:getCurLangShortcut() then
			slot0._dropLangChange:SetValue(slot8 - 1)

			break
		end
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0._btnShow:AddClickListener(slot0._onClickShow, slot0)
	slot0._btnHide:AddClickListener(slot0._onClickHide, slot0)
	slot0._btnDelete:AddClickListener(slot0._onClickDelete, slot0)
	slot0._inputSearch:AddOnValueChanged(slot0._onSearchValueChanged, slot0)
	slot0._inputSearch:AddOnEndEdit(slot0._onSearchEndEdit, slot0)
	slot0._dropLangChange:AddOnValueChanged(slot0._onLangChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btnShow:RemoveClickListener()
	slot0._btnHide:RemoveClickListener()
	slot0._btnDelete:RemoveClickListener()

	if slot0._inputSearch then
		slot0._inputSearch:RemoveOnValueChanged()
		slot0._inputSearch:RemoveOnEndEdit()
	end

	slot0._dropLangChange:RemoveOnValueChanged()
end

function slot0.onOpen(slot0)
	slot0._state = uv0

	slot0:_updateBtns()
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0._goLangItemList) do
		slot5:onClose()
	end

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0._onClickShow(slot0)
	if slot0._state == uv0 then
		slot0._state = uv1
		slot0._tweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._rect, 0, 0.2, slot0._onShow, slot0)
	end
end

function slot0._onShow(slot0)
	slot0._tweenId = nil
	slot0._state = uv0

	slot0:_updateBtns()
end

function slot0._onClickHide(slot0)
	if slot0._state == uv0 then
		slot0._state = uv1
		slot0._tweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._rect, -1740, 0.2, slot0._onHide, slot0)
	end
end

function slot0._onClickDelete(slot0)
	GMLangController.instance:clearInUse()
end

function slot0._onSearchValueChanged(slot0, slot1)
	GMLangTxtModel.instance:setSearch(slot1)
end

function GMLangTxtModel._onSearchEndEdit(slot0, slot1)
end

function slot0._onHide(slot0)
	slot0._tweenId = nil
	slot0._state = uv0

	slot0:_updateBtns()
end

function slot0._updateBtns(slot0)
	gohelper.setActive(slot0._btnShow.gameObject, slot0._state == uv0)
	gohelper.setActive(slot0._btnHide.gameObject, slot0._state == uv1)
end

function slot0._onLangChange(slot0, slot1)
	slot2 = slot0.supportLangs[slot1 + 1]

	for slot9 = 0, ViewMgr.instance:getUIRoot():GetComponentsInChildren(gohelper.Type_TextMesh, true).Length - 1 do
		if GMLangController.instance:getInUseDic()[slot5[slot9].text] then
			slot10.text = slot12[slot2]
		end
	end

	GMLangController.instance:changeLang(slot2)

	for slot11 = 0, slot3:GetComponentsInChildren(typeof(SLFramework.UGUI.SingleImage), true).Length - 1 do
		slot7[slot11]:UnLoadImage()
	end

	SLFramework.UnityHelper.ResGC()

	for slot11, slot12 in pairs({
		[slot12] = slot12.curImageUrl
	}) do
		if not string.nilorempty(slot12) then
			slot11:LoadImage(slot12)
		end
	end
end

function slot0.onLangTxtClick(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._goLangItemList) do
		slot6:updateStr(slot1)
	end
end

return slot0
