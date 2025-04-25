module("modules.logic.gm.view.GMFightEntityItem", package.seeall)

slot0 = class("GMFightEntityItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._btn = gohelper.findChildButtonWithAudio(slot1, "btn")
	slot0._selectImg = gohelper.findChildImage(slot1, "btn")
	slot0._icon = gohelper.findChildSingleImage(slot1, "image")
	slot0._imgIcon = gohelper.findChildImage(slot1, "image")
	slot0._imgCareer = gohelper.findChildImage(slot1, "image/career")
	slot0._txtName = gohelper.findChildText(slot1, "btn/name")
	slot0._txtId = gohelper.findChildText(slot1, "btn/id")
	slot0._txtUid = gohelper.findChildText(slot1, "btn/uid")
end

function slot0.addEventListeners(slot0)
	slot0._btn:AddClickListener(slot0._onClickThis, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btn:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._icon:UnLoadImage()

	slot2 = slot0._mo:isMonster() and lua_monster.configDict[slot0._mo.modelId] or lua_character.configDict[slot0._mo.modelId]

	if slot0._mo:isCharacter() then
		slot0._icon:LoadImage(ResUrl.getHeadIconSmall(FightConfig.instance:getSkinCO(slot1.originSkin).retangleIcon))
	elseif slot0._mo:isMonster() then
		gohelper.getSingleImage(slot0._imgIcon.gameObject):LoadImage(ResUrl.monsterHeadIcon(slot3.headIcon))

		slot0._imgIcon.enabled = true
	end

	if slot1:getCareer() ~= 0 then
		UISpriteSetMgr.instance:setEnemyInfoSprite(slot0._imgCareer, "sxy_" .. tostring(slot4))
	end

	slot8 = FightDataHelper.entityMgr:isDeadUid(slot0._mo.id)
	slot9 = slot0._mo.side == FightEnum.EntitySide.MySide
	slot10 = FightDataHelper.entityMgr:isSp(slot0._mo.id) and "特殊怪" or (FightDataHelper.entityMgr:isSub(slot0._mo.id) and "<color=#FFA500>替补</color>" or "") .. (slot0._mo:isCharacter() and "角色" or "怪物")

	if slot0._mo.id == FightEntityScene.MySideId then
		slot0._txtName.text = "维尔汀"
	elseif slot0._mo.id == FightEntityScene.EnemySideId then
		slot0._txtName.text = "敌方维尔汀"
	else
		slot0._txtName.text = string.format("%s--%s", slot10, slot0._mo:getEntityName())
	end

	slot0._txtId.text = "ID" .. tostring(slot0._mo.id)
	slot0._txtUid.text = "UID" .. tostring(slot0._mo.modelId)
	slot11 = slot8 and "#AAAAAA" or slot5 and "#539450" or "#9C4F30"

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtName, slot11)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtId, slot11)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtUid, slot11)
	ZProj.UGUIHelper.SetGrayscale(slot0._icon.gameObject, slot8)
end

function slot0.onDestroy(slot0)
	slot0._icon:UnLoadImage()
end

function slot0._onClickThis(slot0)
	if not slot0._isSelect then
		slot0._view:setSelect(slot0._mo)
	end
end

function slot0.onSelect(slot0, slot1)
	slot0._isSelect = slot1

	SLFramework.UGUI.GuiHelper.SetColor(slot0._selectImg, slot1 and "#9ADEF0" or "#FFFFFF")

	if slot1 then
		GMFightEntityModel.instance:setEntityMO(slot0._mo)
		GMController.instance:dispatchEvent(GMFightEntityView.Evt_SelectHero, slot0._mo)
	end
end

return slot0
