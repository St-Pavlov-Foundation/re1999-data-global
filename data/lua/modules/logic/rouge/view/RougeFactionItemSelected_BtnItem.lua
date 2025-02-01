module("modules.logic.rouge.view.RougeFactionItemSelected_BtnItem", package.seeall)

slot0 = class("RougeFactionItemSelected_BtnItem", UserDataDispose)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#go_lock")
	slot0._lockAnim = gohelper.onceAddComponent(slot0._golock, gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._itemClick:AddClickListener(slot0._onItemClick, slot0)
end

function slot0.removeEvents(slot0)
	if slot0._itemClick then
		slot0._itemClick:RemoveClickListener()

		slot0._itemClick = nil
	end
end

slot1 = SLFramework.UGUI.RectTrHelper

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0._parent = slot1
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._trans = slot1.transform

	slot0:onInitView()
	slot0:addEvents()
end

function slot0.transform(slot0)
	return slot0._trans
end

function slot0.setIndex(slot0, slot1)
	slot0._index = slot1
end

function slot0.index(slot0)
	return slot0._index
end

function slot0._getDetailTrans(slot0)
	return slot0._parent._detailTrans
end

function slot0._getDetailText(slot0)
	return slot0._parent._txtdec
end

function slot0._getDetailIcon(slot0)
	return slot0._parent._detailimageicon
end

function slot0._onItemClick(slot0)
	slot0._parent:_btnItemOnSelectIndex(slot0:index(), slot0._isUnlock)
end

function slot0._editableInitView(slot0)
	slot0._itemClick = gohelper.getClickWithAudio(slot0.viewGO)
	slot0._normalIcon = gohelper.findChildImage(slot0._gonormal, "icon")
	slot0._selectIcon = gohelper.findChildImage(slot0._goselect, "icon")

	slot0:setData(nil)
	slot0:setSelected(false)
end

function slot0._getActiveSkillCO(slot0, slot1, slot2)
	return RougeOutsideModel.instance:config():getSkillCo(slot1, slot2)
end

function slot0.setData(slot0, slot1, slot2, slot3)
	slot0._skillId = slot2
	slot0._isUnlock = slot3
	slot0._skillType = slot1

	if not slot2 then
		slot0:setActive(false)

		return
	end

	if not string.nilorempty(slot0:_getActiveSkillCO(slot0._skillType, slot2) and slot4.icon) then
		UISpriteSetMgr.instance:setRouge2Sprite(slot0._normalIcon, slot5, true)
		UISpriteSetMgr.instance:setRouge2Sprite(slot0._selectIcon, slot5, true)
	else
		logError(string.format("未配置肉鸽流派技能图标, 技能类型 = %s, 技能id = %s", slot1, slot2))
	end

	gohelper.setActive(slot0._golock, not slot0._isUnlock)
	slot0._lockAnim:Play(slot0._isUnlock and "idle" or "unlock")
	slot0:setActive(true)
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
end

function slot0.onUnlocked(slot0)
	slot0._isUnlock = true

	slot0:setSelected(false)
	SLFramework.AnimatorPlayer.Get(slot0._lockAnim.gameObject):Play("unlock", slot0.endPayAnim, slot0)
end

function slot0.endPayAnim(slot0)
	gohelper.setActive(slot0._golock, false)
end

function slot0.onDestroyView(slot0)
	slot0:removeEvents()
	slot0:__onDispose()
end

function slot0.setSelected(slot0, slot1)
	if slot0._isSelected == slot1 then
		return
	end

	slot0._isSelected = slot1

	gohelper.setActive(slot0._gonormal, not slot1)
	gohelper.setActive(slot0._goselect, slot1)

	if slot1 then
		slot0:_resetDetailTxt()
		slot0:_refreshDetailIcon()
	end
end

function slot0.isSelected(slot0)
	return slot0._isSelected or false
end

function slot0._resetDetailTxt(slot0)
	slot1 = slot0:_getDetailText()

	if not slot0._skillId then
		slot1.text = ""

		return
	end

	slot1.text = slot0:_getActiveSkillCO(slot0._skillType, slot0._skillId).desc
end

function slot0._refreshDetailIcon(slot0)
	if not slot0._skillId then
		return
	end

	UISpriteSetMgr.instance:setRouge2Sprite(slot0:_getDetailIcon(), slot0:_getActiveSkillCO(slot0._skillType, slot0._skillId).icon)
end

return slot0
