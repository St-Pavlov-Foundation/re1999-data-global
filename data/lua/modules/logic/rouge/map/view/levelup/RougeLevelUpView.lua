module("modules.logic.rouge.map.view.levelup.RougeLevelUpView", package.seeall)

local var_0_0 = class("RougeLevelUpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._btnclosebtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closebtn")
	arg_1_0._imagefaction = gohelper.findChildImage(arg_1_0.viewGO, "Left/#image_faction")
	arg_1_0._txtfaction = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_faction")
	arg_1_0._txtlevel1 = gohelper.findChildText(arg_1_0.viewGO, "Right/level/#txt_level1")
	arg_1_0._txtlevel2 = gohelper.findChildText(arg_1_0.viewGO, "Right/level/#txt_level2")
	arg_1_0._gopoint = gohelper.findChild(arg_1_0.viewGO, "Right/volume/layout/#go_point")
	arg_1_0._txttalen = gohelper.findChildText(arg_1_0.viewGO, "Right/talen/#txt_talen")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosebtn:AddClickListener(arg_2_0._btnclosebtnOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosebtn:RemoveClickListener()
end

function var_0_0._btnclosebtnOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.pointGoList = arg_5_0:getUserDataTb_()

	gohelper.setActive(arg_5_0._gopoint, false)
	arg_5_0._simagebg:LoadImage("singlebg/rouge/team/rouge_team_rolegroupbg.png")
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.LvUp)

	arg_7_0.rougeInfo = RougeModel.instance:getRougeInfo()

	arg_7_0:refreshStyle()
	arg_7_0:refreshLevel()
	arg_7_0:refreshCapacity()
	arg_7_0:refreshTalent()
	arg_7_0:playPointAnim()
end

function var_0_0.refreshStyle(arg_8_0)
	local var_8_0 = arg_8_0.rougeInfo.style
	local var_8_1 = arg_8_0.rougeInfo.season
	local var_8_2 = lua_rouge_style.configDict[var_8_1][var_8_0]

	arg_8_0._txtfaction.text = var_8_2.name

	UISpriteSetMgr.instance:setRouge2Sprite(arg_8_0._imagefaction, string.format("%s_light", var_8_2.icon))
end

function var_0_0.refreshLevel(arg_9_0)
	arg_9_0._txtlevel1.text = "Lv." .. arg_9_0.viewParam.preLv
	arg_9_0._txtlevel2.text = "Lv." .. arg_9_0.viewParam.curLv
end

function var_0_0.refreshCapacity(arg_10_0)
	local var_10_0 = arg_10_0.viewParam.preTeamSize
	local var_10_1 = arg_10_0.viewParam.curTeamSize

	for iter_10_0 = 1, var_10_1 do
		local var_10_2 = gohelper.cloneInPlace(arg_10_0._gopoint)
		local var_10_3 = var_10_2:GetComponent(gohelper.Type_Image)

		gohelper.setActive(var_10_2, true)

		if var_10_0 < iter_10_0 then
			table.insert(arg_10_0.pointGoList, var_10_2)
			UISpriteSetMgr.instance:setRougeSprite(var_10_3, "rouge_team_volume_light")
		else
			UISpriteSetMgr.instance:setRougeSprite(var_10_3, "rouge_team_volume_2")
		end
	end
end

function var_0_0.refreshTalent(arg_11_0)
	arg_11_0._txttalen.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_lv_up_talent"), {
		1
	})
end

var_0_0.WaitTime = 0.5

function var_0_0.playPointAnim(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._playPointAnim, arg_12_0)
	TaskDispatcher.runDelay(arg_12_0._playPointAnim, arg_12_0, var_0_0.WaitTime)
end

function var_0_0._playPointAnim(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.pointGoList) do
		iter_13_1 = gohelper.findChild(iter_13_1, "green")

		gohelper.setActive(iter_13_1, true)
	end
end

function var_0_0.onClose(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._playPointAnim, arg_14_0)
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0._simagebg:UnLoadImage()
end

return var_0_0
