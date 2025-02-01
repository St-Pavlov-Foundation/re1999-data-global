module("modules.logic.rouge.dlc.101.view.RougeHeroGroupFightView_1_101", package.seeall)

slot0 = class("RougeHeroGroupFightView_1_101", BaseView)

function slot0.onInitView(slot0)
	slot0._gorouge = gohelper.findChild(slot0.viewGO, "herogroupcontain/hero/heroitem/#go_rouge")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.onOpen(slot0)
	slot2 = RougeMapModel.instance:getCurNode() and slot1.eventMo

	if not slot2 or not slot2:getSurpriseAttackList() or #slot3 <= 0 then
		return
	end

	RougeDLCController101.instance:openRougeDangerousView()
end

function slot0._editableInitView(slot0)
end

return slot0
