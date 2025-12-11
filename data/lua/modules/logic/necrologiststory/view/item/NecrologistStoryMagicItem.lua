module("modules.logic.necrologiststory.view.item.NecrologistStoryMagicItem", package.seeall)

local var_0_0 = class("NecrologistStoryMagicItem", NecrologistStoryControlItem)

function var_0_0.onInit(arg_1_0)
	arg_1_0.anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.bg = gohelper.findChild(arg_1_0.viewGO, "root/image")
	arg_1_0.simageMagic = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#btn_zhouyu/simageMagic")
	arg_1_0.btnMagic = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_zhouyu")
	arg_1_0.goReddot = gohelper.findChild(arg_1_0.viewGO, "root/#btn_zhouyu/#reddot")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnMagic, arg_2_0.onClickMagic, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnMagic)
end

function var_0_0.onClickMagic(arg_4_0)
	if arg_4_0.isClicked then
		return
	end

	arg_4_0.anim:Play("click", 0, 0)

	local var_4_0 = string.split(arg_4_0._controlParam, "#")
	local var_4_1 = tonumber(var_4_0[2])

	if var_4_1 == 1 then
		local var_4_2 = tonumber(var_4_0[3])

		NecrologistStoryController.instance:openTipView(var_4_2)
	elseif var_4_1 == 2 then
		local var_4_3 = var_4_0[3]

		NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnChangePic, var_4_3)
	end

	gohelper.setActive(arg_4_0.goReddot, false)

	arg_4_0.isClicked = true

	arg_4_0:onPlayFinish()
end

function var_0_0.onPlayStory(arg_5_0, arg_5_1)
	arg_5_0.isClicked = false

	gohelper.setActive(arg_5_0.goReddot, true)

	local var_5_0 = string.split(arg_5_0._controlParam, "#")[1]

	arg_5_0.simageMagic:LoadImage(string.format("singlebg_lang/txt_rolestory/magic/%s.png", var_5_0), arg_5_0.onMagicLoaded, arg_5_0)
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.StartMagic)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_qiutu_award_all)
end

function var_0_0.onMagicLoaded(arg_6_0)
	ZProj.UGUIHelper.SetImageSize(arg_6_0.simageMagic.gameObject)

	local var_6_0 = recthelper.getWidth(arg_6_0.simageMagic.transform)

	recthelper.setWidth(arg_6_0.bg.transform, var_6_0 + 140)
end

function var_0_0.caleHeight(arg_7_0)
	return 100
end

function var_0_0.isDone(arg_8_0)
	return arg_8_0.isClicked
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0.simageMagic:UnLoadImage()
end

function var_0_0.getResPath()
	return "ui/viewres/dungeon/rolestory/necrologiststorymagicitem.prefab"
end

return var_0_0
