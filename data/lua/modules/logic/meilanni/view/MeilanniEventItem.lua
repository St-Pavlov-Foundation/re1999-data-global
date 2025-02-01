module("modules.logic.meilanni.view.MeilanniEventItem", package.seeall)

slot0 = class("MeilanniEventItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "icon/#image_icon")
	slot0._goinfo = gohelper.findChild(slot0.viewGO, "#go_info")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#go_info/#txt_title")
	slot0._imagephoto = gohelper.findChildImage(slot0.viewGO, "#image_photo")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0.viewGO)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.setPhotoVisible(slot0, slot1)
	gohelper.setActive(slot0._imagephoto.gameObject, slot0._showModel and slot1)
end

function slot0.playAnim(slot0, slot1)
	slot0._animator:Play(slot1)
end

function slot0._editableAddEvents(slot0)
	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._click:RemoveClickListener()
end

function slot0._onClick(slot0)
	if slot0._clickEnabled == false then
		MeilanniController.instance:dispatchEvent(MeilanniEvent.resetDialogPos)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_story_open)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.clickEventItem, slot0)
end

function slot0.isSelected(slot0)
	return slot0._isSelected
end

function slot0.setSelected(slot0, slot1)
	slot0._isSelected = slot1

	if slot1 then
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "icon/glow/glow_yellow"), slot0._config.type ~= 1)
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "icon/glow/glow_red"), slot0._config.type == 1)
		slot0:playAnim("select")
	else
		slot0:playAnim("unselect")
	end
end

function slot0.setClickEnabled(slot0, slot1)
	slot0._clickEnabled = slot1
end

function slot0.setGray(slot0, slot1)
	if slot0._speicalType then
		return
	end

	UISpriteSetMgr.instance:setMeilanniSprite(slot0._imageicon, slot1 and "bg_tanhao_1" or "bg_tanhaohui")
end

function slot0.isSpecialType(slot0)
	return slot0._speicalType
end

function slot0.updateInfo(slot0, slot1)
	slot0._info = slot1
	slot0._eventId = slot0._info.eventId
	slot0._config = lua_activity108_event.configDict[slot0._eventId]

	transformhelper.setLocalPos(slot0.viewGO.transform, string.splitToNumber(slot0._config.pos, "#")[1] or 0, slot2[2] or 0, 0)

	slot0._speicalType = slot0._config.type == 1

	UISpriteSetMgr.instance:setMeilanniSprite(slot0._imageicon, slot0._speicalType and "bg_tanhao" or "bg_tanhao_1")

	if slot0._speicalType then
		recthelper.setAnchorX(slot0._imageicon.transform, -11)
	end

	slot5 = not string.nilorempty(slot0._config.model)
	slot0._showModel = slot5

	gohelper.setActive(slot0._imagephoto.gameObject, slot5)

	if slot5 then
		UISpriteSetMgr.instance:setMeilanniSprite(slot0._imagephoto, slot0._config.model)
		transformhelper.setLocalPos(slot0._imagephoto.transform, string.splitToNumber(slot0._config.modelPos, "#")[1] or 0, slot6[2] or 0, 0)
	end

	if not string.nilorempty(slot0._config.title) then
		gohelper.setActive(slot0._goinfo, true)

		slot0._txttitle.text = slot0._config.title
	end
end

function slot0._updateImage(slot0)
end

function slot0.dispose(slot0)
	if not slot0.viewGO.activeSelf then
		gohelper.destroy(slot0.viewGO)

		return
	end

	gohelper.setActive(slot0._imagephoto.gameObject, false)

	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)

	slot0._animatorPlayer:Play("disappear", slot0._disappear, slot0)
end

function slot0._disappear(slot0)
	gohelper.destroy(slot0.viewGO)
end

function slot0.onDestroyView(slot0)
end

return slot0
