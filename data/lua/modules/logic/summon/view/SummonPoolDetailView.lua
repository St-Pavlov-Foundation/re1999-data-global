module("modules.logic.summon.view.SummonPoolDetailView", package.seeall)

slot0 = class("SummonPoolDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagetop = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_top")
	slot0._simagebottom = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bottom")
	slot0._txtinfotitle = gohelper.findChildText(slot0.viewGO, "info/#txt_infotitle")
	slot0._txtinfotitleEn = gohelper.findChildText(slot0.viewGO, "info/#txt_infotitle/#txt_infotitleEn")
	slot0._btnclose = gohelper.findChildButton(slot0.viewGO, "#btn_close")
	slot0._gospecialtitle = gohelper.findChild(slot0.viewGO, "info/#go_specialtitle")
	slot0._txtspecialtitlecn = gohelper.findChildText(slot0.viewGO, "info/#go_specialtitle/#txt_specialtitlecn")
	slot0._goline = gohelper.findChild(slot0.viewGO, "#go_line")
	slot0._txttitlecn = gohelper.findChildText(slot0.viewGO, "#txt_titlecn")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btnCloseOnClick, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonPoolDetailCategoryClick, slot0._refreshTitle, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonPoolDetailCategoryClick, slot0._refreshTitle, slot0)
end

function slot0._editableInitView(slot0)
	slot0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	slot0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))

	slot0._txttitleen = gohelper.findChildText(slot0._txttitlecn.gameObject, "titleen")
	slot0._gotitleline = gohelper.findChild(slot0._txttitlecn.gameObject, "Line")
end

function slot0._refreshTitle(slot0, slot1)
	gohelper.setActive(slot0._txtinfotitle.gameObject, slot1 ~= 1)
	gohelper.setActive(slot0._gospecialtitle, slot1 == 1)

	slot2 = SummonConfig.instance:getSummonPool(slot0._poolId)
	slot3, slot4 = nil
	slot5 = true

	if not slot0._summonSimulationActId then
		slot3 = slot2.nameCn
		slot4 = slot2.nameEn
	else
		slot3 = ItemConfig.instance:getItemCo(SummonSimulationPickConfig.instance:getSummonConfigById(slot0._summonSimulationActId).itemId).name
		slot4 = ""
		slot5 = false
	end

	if slot1 ~= 1 then
		slot0._txtinfotitle.text = SummonPoolDetailCategoryListModel.getName(slot1)
		slot0._txtinfotitleEn.text = SummonPoolDetailCategoryListModel.getNameEn(slot1)
	else
		slot6, slot7 = slot0:_splitTitle2Part(slot3, 1)
		slot0._txtspecialtitlecn.text = string.format("<size=60>%s</size>%s", slot6, slot7)
	end

	slot0._txttitlecn.text = string.format("「%s」%s", slot3, luaLang("ruledetail"))

	if slot5 then
		slot0._txttitleen.text = string.format("「%s」%s", slot4, "Rules")
	end

	gohelper.setActive(slot0._gotitleline, slot5)
	gohelper.setActive(slot0._txttitleen, slot5)
	slot0:_refreshline(slot1)
end

function slot0._splitTitle2Part(slot0, slot1, slot2)
	slot2 = slot2 or 1

	if string.nilorempty(slot1) or GameUtil.utf8len(slot1) <= slot2 then
		return slot1, ""
	end

	slot3 = GameUtil.utf8sub(slot1, 1, slot2)
	slot4 = ""

	if GameUtil.utf8len(slot1) >= slot2 + 1 then
		slot4 = GameUtil.utf8sub(slot1, slot2 + 1, GameUtil.utf8len(slot1) - slot2)
	end

	return slot3, slot4
end

function slot0._refreshUI(slot0)
	slot1 = SummonConfig.instance:getPoolDetailConfig(slot0._poolDetailId)

	SummonPoolDetailCategoryListModel.instance:initCategory()
	slot0.viewContainer._views[1]:selectCell(1, true)
end

function slot0._refreshline(slot0, slot1)
	if slot1 ~= 1 then
		gohelper.setActive(slot0._goline, true)

		return
	end

	gohelper.setActive(slot0._goline, not SummonMainModel.isProbUp(SummonConfig.instance:getSummonPool(slot0._poolId)))
end

function slot0.onUpdateParam(slot0)
	slot0:_initData()
end

function slot0.onOpen(slot0)
	slot0:_initData()
end

function slot0._initData(slot0)
	slot0._poolId = slot0.viewParam.poolId
	slot0._luckyBagId = slot0.viewParam.luckyBagId
	slot0._summonSimulationActId = slot0.viewParam.summonSimulationActId

	SummonPoolDetailCategoryListModel.instance:setJumpLuckyBag(slot0._luckyBagId)
	slot0:_refreshUI()
	slot0:_refreshTitle(1)
	SummonController.instance:statViewPoolDetail(slot0._poolId)
	SummonController.instance:setPoolInfo(slot0.viewParam)
end

function slot0._btnCloseOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

function slot0.onClose(slot0)
	SummonController.instance:statExitPoolDetail()
end

function slot0.onDestroyView(slot0)
	slot0._simagetop:UnLoadImage()
	slot0._simagebottom:UnLoadImage()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
