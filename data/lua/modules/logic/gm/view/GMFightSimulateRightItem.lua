module("modules.logic.gm.view.GMFightSimulateRightItem", package.seeall)

slot0 = class("GMFightSimulateRightItem", ListScrollCell)
slot1 = Color.New(1, 0.8, 0.8, 1)
slot2 = Color.white
slot3 = nil

function slot0.init(slot0, slot1)
	slot0._btn = gohelper.findChildButtonWithAudio(slot1, "btn")

	slot0._btn:AddClickListener(slot0._onClickItem, slot0)

	slot0._imgBtn = gohelper.findChildImage(slot1, "btn")
	slot0._txtName = gohelper.findChildText(slot1, "btn/Text")
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._episodeCO = slot1
	slot0._txtName.text = slot0._episodeCO.name
	slot0._imgBtn.color = slot0._episodeCO.id == uv0 and uv1 or uv2
end

function slot0._onClickItem(slot0)
	uv0 = slot0._episodeCO.id
	slot0._imgBtn.color = uv1

	slot0._view:closeThis()

	if DungeonModel.isBattleEpisode(slot0._episodeCO) then
		JumpModel.instance.jumpFromFightSceneParam = "99"

		DungeonFightController.instance:enterFight(slot0._episodeCO.chapterId, slot0._episodeCO.id)
	else
		logError("GMToolView 不支持该类型的关卡" .. slot0._episodeCO.id)
	end
end

function slot0.onDestroy(slot0)
	if slot0._btn then
		slot0._btn:RemoveClickListener()

		slot0._btn = nil
	end
end

return slot0
