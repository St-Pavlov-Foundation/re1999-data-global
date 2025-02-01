module("modules.logic.versionactivity1_2.jiexika.view.Activity114FullPhotoView", package.seeall)

slot0 = class("Activity114FullPhotoView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagephoto = gohelper.findChildSingleImage(slot0.viewGO, "#simage_photo")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_leftArrow")
	slot0._btnright = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_rightArrow")
	slot0._txtname = gohelper.findChildTextMesh(slot0.viewGO, "#txt_name")
	slot0._txtnameen = gohelper.findChildTextMesh(slot0.viewGO, "#txt_name/#txt_nameen")
	slot0._txtpage = gohelper.findChildTextMesh(slot0.viewGO, "#txt_page")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#simage_photo/#go_empty")
	slot0._animationEventWrap = slot0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._image = gohelper.findChildImage(slot0.viewGO, "#simage_photo")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.closeThis, slot0)
	slot0._btnleft:AddClickListener(slot0.onLeftPhoto, slot0)
	slot0._btnright:AddClickListener(slot0.onRightPhoto, slot0)
	slot0._animationEventWrap:AddEventListener("switch", slot0.updatePhotoShow, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnleft:RemoveClickListener()
	slot0._btnright:RemoveClickListener()
	slot0._animationEventWrap:RemoveAllEventListener()
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot0.nowShowIndex = slot0.viewParam

	slot0:updatePhotoShow()
end

function slot0.updatePhotoShow(slot0)
	slot0._animLock = nil
	slot2 = Activity114Config.instance:getPhotoCoList(Activity114Model.instance.id)[slot0.nowShowIndex]

	if Activity114Model.instance.unLockPhotoDict[slot0.nowShowIndex] then
		slot0._txtname.text = slot2.name
		slot0._txtnameen.text = slot2.nameEn

		gohelper.setActive(slot0._goempty, false)

		slot0._image.enabled = true

		slot0._simagephoto:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("photo/" .. slot1[slot0.nowShowIndex].bigCg .. ".png"))
	else
		slot0._txtname.text = luaLang("hero_display_level0_variant")
		slot0._txtnameen.text = ""

		gohelper.setActive(slot0._goempty, true)

		slot0._image.enabled = false
	end

	slot0._txtpage.text = slot2.desc
end

function slot0.onLeftPhoto(slot0)
	if slot0._animLock then
		return
	end

	slot0._animLock = true

	if slot0.nowShowIndex - 1 <= 0 then
		slot1 = 9
	end

	slot0.nowShowIndex = slot1

	slot0._anim:Play(UIAnimationName.Left, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
end

function slot0.onRightPhoto(slot0)
	if slot0._animLock then
		return
	end

	slot0._animLock = true

	if slot0.nowShowIndex + 1 > 9 then
		slot1 = 1
	end

	slot0.nowShowIndex = slot1

	slot0._anim:Play(UIAnimationName.Right, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mail_close)
end

function slot0.onDestroyView(slot0)
	slot0._simagephoto:UnLoadImage()
end

return slot0
