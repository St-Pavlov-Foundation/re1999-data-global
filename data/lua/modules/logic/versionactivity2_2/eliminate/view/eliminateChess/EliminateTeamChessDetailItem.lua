module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateTeamChessDetailItem", package.seeall)

slot0 = class("EliminateTeamChessDetailItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imageQuality = gohelper.findChildImage(slot0.viewGO, "#image_Quality")
	slot0._goLocked = gohelper.findChild(slot0.viewGO, "#go_Locked")
	slot0._goSelected = gohelper.findChild(slot0.viewGO, "#go_Selected")
	slot0._imageChess = gohelper.findChildImage(slot0.viewGO, "ChessMask/#image_Chess")
	slot0._txtFireNum = gohelper.findChildText(slot0.viewGO, "image_Fire/#txt_FireNum")
	slot0._goResources = gohelper.findChild(slot0.viewGO, "#go_Resources")
	slot0._goResource = gohelper.findChild(slot0.viewGO, "#go_Resources/#go_Resource")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = ZProj.UIEffectsCollection

function slot0._editableAddEvents(slot0)
	slot0._goClick = gohelper.getClick(slot0.viewGO)

	slot0._goClick:AddClickListener(slot0.onClick, slot0)
end

function slot0._editableRemoveEvents(slot0)
	if slot0._goClick then
		slot0._goClick:RemoveClickListener()
	end
end

function slot0.onClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.ShowChessInfo, slot0._soliderId)
end

function slot0.setSoliderId(slot0, slot1)
	slot0._soliderId = slot1

	slot0:initInfo()
	slot0:initResource()
	slot0:refreshView()
end

function slot0.refreshView(slot0)
	if slot0._soliderId == nil then
		return
	end

	slot0:canUse()
	slot0:setGrayState()
end

function slot0.setGrayState(slot0)
	if slot0._effectCollection == nil then
		slot0._effectCollection = uv0.Get(slot0.viewGO)
	end

	if slot0._effectCollection then
		slot0._effectCollection:SetGray(not slot0._canUse)
	end

	if slot0.cacheColor == nil then
		slot0.cacheColor = slot0._imageChess.color
	end

	slot0.cacheColor.a = slot0._canUse and 1 or 0.5
	slot0._imageChess.color = slot0.cacheColor
end

function slot0.canUse(slot0)
	slot0._canUse = EliminateTeamChessModel.instance:canUseChess(slot0._soliderId)

	return slot0._canUse
end

function slot0.initInfo(slot0)
	slot1 = EliminateConfig.instance:getSoldierChessConfig(slot0._soliderId)
	slot0._txtFireNum.text = slot1.defaultPower

	if slot1 and not string.nilorempty(slot1.resPic) then
		UISpriteSetMgr.instance:setV2a2ChessSprite(slot0._imageChess, slot1.resPic, false)
	end

	UISpriteSetMgr.instance:setV2a2EliminateSprite(slot0._imageQuality, EliminateConfig.instance:getSoldierChessQualityImageName(slot1.level), false)
end

function slot0.initResource(slot0)
	slot0._cost = EliminateConfig.instance:getSoldierChessConfigConst(slot0._soliderId)

	if not slot0._cost then
		return
	end

	slot0._resourceItem = slot0:getUserDataTb_()

	for slot4, slot5 in ipairs(slot0._cost) do
		slot6 = slot5[1]
		slot8 = gohelper.clone(slot0._goResource, slot0._goResources, slot6)
		slot9 = gohelper.findChildImage(slot8, "#image_Quality")
		slot10 = gohelper.findChildText(slot8, "#image_Quality/#txt_ResourceNum")

		UISpriteSetMgr.instance:setV2a2EliminateSprite(slot9, EliminateTeamChessEnum.ResourceTypeToImagePath[slot6], false)

		slot10.text = slot5[2]

		gohelper.setActive(slot8, true)

		slot0._resourceItem[slot6] = {
			item = slot8,
			resourceImage = slot9,
			resourceNumberText = slot10
		}
	end
end

function slot0.updateInfo(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
