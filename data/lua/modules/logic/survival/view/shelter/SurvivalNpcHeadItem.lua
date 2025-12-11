module("modules.logic.survival.view.shelter.SurvivalNpcHeadItem", package.seeall)

local var_0_0 = class("SurvivalNpcHeadItem", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1
	arg_2_0._goempty = gohelper.findChild(arg_2_0.viewGO, "#go_empty")
	arg_2_0._gohas = gohelper.findChild(arg_2_0.viewGO, "#go_has")
	arg_2_0._goput = gohelper.findChild(arg_2_0.viewGO, "#go_has/#go_put")
	arg_2_0._simage_icon = gohelper.findChildSingleImage(arg_2_0.viewGO, "#go_has/go_icon/#simage_icon")
	arg_2_0._txtname = gohelper.findChildText(arg_2_0.viewGO, "#go_has/#txt_name")
	arg_2_0._goSelected = gohelper.findChild(arg_2_0.viewGO, "#go_Selected")
	arg_2_0._btnclick = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_click")
	arg_2_0._btnremove = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_has/#btn_remove")
end

function var_0_0.onStart(arg_3_0)
	return
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0:addClickCb(arg_4_0._btnclick, arg_4_0.onClickBtnClick, arg_4_0)
	arg_4_0:addClickCb(arg_4_0._btnremove, arg_4_0.onClickBtnRemove, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	return
end

function var_0_0.onDestroy(arg_6_0)
	return
end

function var_0_0.onClickBtnClick(arg_7_0)
	return
end

function var_0_0.onClickBtnRemove(arg_8_0)
	if arg_8_0.onClickBtnRemoveCallBack then
		arg_8_0.onClickBtnRemoveCallBack(arg_8_0.onClickContext, arg_8_0)
	end
end

function var_0_0.setData(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.npcId

	arg_9_0.pos = arg_9_1.pos
	arg_9_0.isFirst = arg_9_1.isFirst
	arg_9_0.npcId = arg_9_1.npcId
	arg_9_0.isSelect = arg_9_1.isSelect or false
	arg_9_0.isPlayPutEffect = arg_9_1.isPlayPutEffect or false
	arg_9_0.isShowBtnRemove = arg_9_1.isShowBtnRemove or false
	arg_9_0.onClickBtnRemoveCallBack = arg_9_1.onClickBtnRemoveCallBack
	arg_9_0.onClickContext = arg_9_1.onClickContext

	gohelper.setActive(arg_9_0._goSelected, arg_9_0.isSelect)

	if not arg_9_0.npcId then
		gohelper.setActive(arg_9_0._goempty, true)
		gohelper.setActive(arg_9_0._gohas, false)

		return
	end

	if arg_9_0.isPlayPutEffect and not arg_9_0.isFirst and arg_9_0.npcId and arg_9_0.npcId ~= var_9_0 then
		arg_9_0:playPutEffect()
	end

	arg_9_0.config = SurvivalConfig.instance:getNpcConfig(arg_9_0.npcId)

	gohelper.setActive(arg_9_0._btnremove, arg_9_0.isShowBtnRemove)
	gohelper.setActive(arg_9_0._goempty, false)
	gohelper.setActive(arg_9_0._gohas, true)

	local var_9_1 = ResUrl.getSurvivalNpcIcon(arg_9_0.config.smallIcon)

	arg_9_0._simage_icon:LoadImage(var_9_1)

	arg_9_0._txtname.text = arg_9_0.config.name
end

function var_0_0.playPutEffect(arg_10_0)
	gohelper.setActive(arg_10_0._goput, false)
	gohelper.setActive(arg_10_0._goput, true)
end

return var_0_0
