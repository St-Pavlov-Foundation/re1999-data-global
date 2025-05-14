module("modules.logic.versionactivity1_2.jiexika.view.Activity114EventSelectItem", package.seeall)

local var_0_0 = class("Activity114EventSelectItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._parent = arg_1_1.parent
	arg_1_0._index = arg_1_1.index
	arg_1_0._go = nil
	arg_1_0._isSelect = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	arg_2_0._btnClick = gohelper.findChildButtonWithAudio(arg_2_1, "#btn_click")
	arg_2_0._goselect = gohelper.findChild(arg_2_1, "#go_selected")
	arg_2_0._btnSelect = gohelper.findChildButtonWithAudio(arg_2_1, "#go_selected/#btn_select")
	arg_2_0._goselectonce = gohelper.findChild(arg_2_1, "#go_selected/#go_once")
	arg_2_0._txtselectoncedesc = gohelper.findChildTextMesh(arg_2_1, "#go_selected/#go_once/#txt_desc")
	arg_2_0._txtselectdesc = gohelper.findChildTextMesh(arg_2_1, "#go_selected/#txt_desc")
	arg_2_0._goselectcheck = gohelper.findChild(arg_2_1, "#go_selected/#go_check")
	arg_2_0._txtselectneed = gohelper.findChildTextMesh(arg_2_1, "#go_selected/#go_check/#txt_need")
	arg_2_0._txtselectrate = gohelper.findChildTextMesh(arg_2_1, "#go_selected/#go_check/#txt_rate")
	arg_2_0._btnselecthelp = gohelper.findChildButtonWithAudio(arg_2_1, "#go_selected/#go_check/#btn_help")
	arg_2_0._goselecttippos = gohelper.findChildComponent(arg_2_1, "#go_selected/#go_tippos", typeof(UnityEngine.Transform))
	arg_2_0._gounselect = gohelper.findChild(arg_2_1, "#go_unselected")
	arg_2_0._txtunselectdesc = gohelper.findChildTextMesh(arg_2_1, "#go_unselected/#txt_desc")
	arg_2_0._gounselectcheck = gohelper.findChild(arg_2_1, "#go_unselected/#go_check")
	arg_2_0._txtunselectneed = gohelper.findChildTextMesh(arg_2_1, "#go_unselected/#go_check/#txt_need")
	arg_2_0._txtunselectrate = gohelper.findChildTextMesh(arg_2_1, "#go_unselected/#go_check/#txt_rate")
	arg_2_0._btnunselecthelp = gohelper.findChildButtonWithAudio(arg_2_1, "#go_unselected/#go_check/#btn_help")
	arg_2_0._gounselecttippos = gohelper.findChildComponent(arg_2_1, "#go_unselected/#go_tippos", typeof(UnityEngine.Transform))
	arg_2_0._goSelectAnim = SLFramework.AnimatorPlayer.Get(arg_2_0._goselect)
	arg_2_0._goUnSelectAnim = arg_2_0._gounselect:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._isFirstEnter = true
	arg_2_0.selectTypeTab = {}

	for iter_2_0 = 1, 5 do
		arg_2_0.selectTypeTab[iter_2_0] = gohelper.findChild(arg_2_0._btnSelect.gameObject, "go_type" .. iter_2_0)
	end

	arg_2_0:setSelect(false)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnClick:AddClickListener(arg_3_0.setSelect, arg_3_0, true)
	arg_3_0._btnSelect:AddClickListener(arg_3_0.selectChoice, arg_3_0)
	arg_3_0._btnselecthelp:AddClickListener(arg_3_0.showHelp, arg_3_0, arg_3_0._goselecttippos)
	arg_3_0._btnunselecthelp:AddClickListener(arg_3_0.showHelp, arg_3_0, arg_3_0._gounselecttippos)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnClick:RemoveClickListener()
	arg_4_0._btnSelect:RemoveClickListener()
	arg_4_0._btnselecthelp:RemoveClickListener()
	arg_4_0._btnunselecthelp:RemoveClickListener()
end

function var_0_0.showHelp(arg_5_0, arg_5_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)
	arg_5_0._parent:showTips(arg_5_0._data, arg_5_1.position)
end

function var_0_0.setSelect(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0._isSelect then
		return
	end

	arg_6_0._isSelect = arg_6_1

	if arg_6_0._isFirstEnter then
		gohelper.setActive(arg_6_0._goselect, false)
		gohelper.setActive(arg_6_0._gounselect, true)

		arg_6_0._isFirstEnter = false
	elseif arg_6_1 then
		arg_6_0._parent:onSelectIndex(arg_6_0._index)
		gohelper.setActive(arg_6_0._goselect, true)
		gohelper.setActive(arg_6_0._gounselect, false)

		arg_6_0._goselect:GetComponent(typeof(UnityEngine.Animator)).enabled = true
	else
		arg_6_0._goSelectAnim:Stop()
		arg_6_0._goSelectAnim:Play(UIAnimationName.Close, arg_6_0.playUnSelectAnimFinish, arg_6_0)
	end
end

function var_0_0.playUnSelectAnimFinish(arg_7_0)
	gohelper.setActive(arg_7_0._goselect, false)
	gohelper.setActive(arg_7_0._gounselect, true)
	arg_7_0._goUnSelectAnim:Play(UIAnimationName.Switch, 0, 0)
end

function var_0_0.updateData(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	arg_8_0._data = arg_8_2
	arg_8_0._selectCb = arg_8_3
	arg_8_0._selectCbObj = arg_8_4

	gohelper.setActive(arg_8_0._goselectonce, arg_8_1 == Activity114Enum.EventContentType.Check_Once)
	gohelper.setActive(arg_8_0._goselectcheck, arg_8_1 ~= Activity114Enum.EventContentType.Normal)
	gohelper.setActive(arg_8_0._gounselectcheck, arg_8_1 ~= Activity114Enum.EventContentType.Normal)
	gohelper.setActive(arg_8_0._txtselectdesc, arg_8_1 ~= Activity114Enum.EventContentType.Check_Once)
	recthelper.setWidth(arg_8_0._txtunselectdesc.transform, arg_8_1 == Activity114Enum.EventContentType.Check_Once and 380 or 500)
	recthelper.setWidth(arg_8_0._txtselectdesc.transform, arg_8_1 == Activity114Enum.EventContentType.Check_Once and 460 or 700)

	local var_8_0 = 5

	if arg_8_1 == Activity114Enum.EventContentType.Normal then
		arg_8_0._txtselectdesc.text = arg_8_2
		arg_8_0._txtunselectdesc.text = arg_8_2
	else
		if arg_8_1 == Activity114Enum.EventContentType.Check then
			arg_8_0._txtselectdesc.text = arg_8_2.desc
		else
			arg_8_0._txtselectoncedesc.text = arg_8_2.desc
		end

		arg_8_0._txtunselectdesc.text = arg_8_2.desc
		var_8_0 = arg_8_2.level
		arg_8_0._txtselectrate.text = arg_8_2.rateDes
		arg_8_0._txtunselectrate.text = arg_8_2.rateDes
		arg_8_0._txtselectneed.text = arg_8_2.realVerify
		arg_8_0._txtunselectneed.text = arg_8_2.realVerify

		SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._txtselectneed, arg_8_2.threshold ~= arg_8_2.realVerify and "#E19C60" or "#FFFFFF")
		SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._txtunselectneed, arg_8_2.threshold ~= arg_8_2.realVerify and "#E19C60" or "#FFFFFF")
	end

	for iter_8_0 = 1, 5 do
		gohelper.setActive(arg_8_0.selectTypeTab[iter_8_0], iter_8_0 == var_8_0)
	end
end

function var_0_0.selectChoice(arg_9_0)
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_click)

	arg_9_0._isFirstEnter = true

	arg_9_0._selectCb(arg_9_0._selectCbObj, arg_9_0._index)
end

function var_0_0.destory(arg_10_0)
	gohelper.destroy(arg_10_0._go)
end

function var_0_0.onDestroy(arg_11_0)
	arg_11_0._go = nil
end

return var_0_0
