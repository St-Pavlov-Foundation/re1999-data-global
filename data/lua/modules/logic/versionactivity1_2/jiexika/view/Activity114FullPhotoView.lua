module("modules.logic.versionactivity1_2.jiexika.view.Activity114FullPhotoView", package.seeall)

local var_0_0 = class("Activity114FullPhotoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagephoto = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_photo")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btnleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_leftArrow")
	arg_1_0._btnright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_rightArrow")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txtnameen = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_name/#txt_nameen")
	arg_1_0._txtpage = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_page")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#simage_photo/#go_empty")
	arg_1_0._animationEventWrap = arg_1_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._image = gohelper.findChildImage(arg_1_0.viewGO, "#simage_photo")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0.onLeftPhoto, arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0.onRightPhoto, arg_2_0)
	arg_2_0._animationEventWrap:AddEventListener("switch", arg_2_0.updatePhotoShow, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnleft:RemoveClickListener()
	arg_3_0._btnright:RemoveClickListener()
	arg_3_0._animationEventWrap:RemoveAllEventListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.nowShowIndex = arg_5_0.viewParam

	arg_5_0:updatePhotoShow()
end

function var_0_0.updatePhotoShow(arg_6_0)
	arg_6_0._animLock = nil

	local var_6_0 = Activity114Config.instance:getPhotoCoList(Activity114Model.instance.id)
	local var_6_1 = var_6_0[arg_6_0.nowShowIndex]

	if Activity114Model.instance.unLockPhotoDict[arg_6_0.nowShowIndex] then
		arg_6_0._txtname.text = var_6_1.name
		arg_6_0._txtnameen.text = var_6_1.nameEn

		gohelper.setActive(arg_6_0._goempty, false)

		arg_6_0._image.enabled = true

		arg_6_0._simagephoto:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("photo/" .. var_6_0[arg_6_0.nowShowIndex].bigCg .. ".png"))
	else
		arg_6_0._txtname.text = luaLang("hero_display_level0_variant")
		arg_6_0._txtnameen.text = ""

		gohelper.setActive(arg_6_0._goempty, true)

		arg_6_0._image.enabled = false
	end

	arg_6_0._txtpage.text = var_6_1.desc
end

function var_0_0.onLeftPhoto(arg_7_0)
	if arg_7_0._animLock then
		return
	end

	arg_7_0._animLock = true

	local var_7_0 = arg_7_0.nowShowIndex - 1

	if var_7_0 <= 0 then
		var_7_0 = 9
	end

	arg_7_0.nowShowIndex = var_7_0

	arg_7_0._anim:Play(UIAnimationName.Left, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
end

function var_0_0.onRightPhoto(arg_8_0)
	if arg_8_0._animLock then
		return
	end

	arg_8_0._animLock = true

	local var_8_0 = arg_8_0.nowShowIndex + 1

	if var_8_0 > 9 then
		var_8_0 = 1
	end

	arg_8_0.nowShowIndex = var_8_0

	arg_8_0._anim:Play(UIAnimationName.Right, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
end

function var_0_0.onClose(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mail_close)
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simagephoto:UnLoadImage()
end

return var_0_0
