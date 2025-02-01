module("modules.logic.rouge.common.comp.RougeHeroGroupComp", package.seeall)

slot0 = class("RougeHeroGroupComp", UserDataDispose)

function slot0.Get(slot0)
	slot1 = uv0.New()

	slot1:init(slot0)

	return slot1
end

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1

	slot0:_editableInitView()
end

function slot0._editableInitView(slot0)
	slot0._btnMember = gohelper.findChildButtonWithAudio(slot0.go, "Root/#btn_Member")
	slot0._goRecovery = gohelper.findChild(slot0.go, "Root/recovery")
	slot0._goLossLife = gohelper.findChild(slot0.go, "Root/bleeding")

	gohelper.setActive(slot0._goRecovery, false)
	gohelper.setActive(slot0._goLossLife, false)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onTeamLifeChange, slot0.onLifeChange, slot0)
end

function slot0.onLifeChange(slot0, slot1)
	if slot1 == RougeMapEnum.LifeChangeStatus.Idle then
		return
	end

	if slot1 == RougeMapEnum.LifeChangeStatus.Add then
		gohelper.setActive(slot0._goRecovery, false)
		gohelper.setActive(slot0._goRecovery, true)

		return
	end

	gohelper.setActive(slot0._goLossLife, false)
	gohelper.setActive(slot0._goLossLife, true)
end

function slot0._btnMemberOnClick(slot0)
	RougeController.instance:openRougeTeamView()
end

function slot0.onOpen(slot0)
	slot0._btnMember:AddClickListener(slot0._btnMemberOnClick, slot0)
end

function slot0.onClose(slot0)
	slot0._btnMember:RemoveClickListener()
end

function slot0.destroy(slot0)
	slot0:__onDispose()
end

return slot0
