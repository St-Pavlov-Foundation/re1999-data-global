module("modules.logic.rouge.view.RougeStoryListItem", package.seeall)

local var_0_0 = class("RougeStoryListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golayout = gohelper.findChild(arg_1_0.viewGO, "#go_layout")
	arg_1_0._simagestoryicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_layout/basic/mask/#simage_storyicon")
	arg_1_0._txtid = gohelper.findChildText(arg_1_0.viewGO, "#go_layout/basic/#txt_id")
	arg_1_0._txtstorynameen = gohelper.findChildText(arg_1_0.viewGO, "#go_layout/basic/#txt_storynameen")
	arg_1_0._txtstorynamecn = gohelper.findChildText(arg_1_0.viewGO, "#go_layout/basic/#txt_storynamecn")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnplay:AddClickListener(arg_2_0._btnplayOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnplay:RemoveClickListener()
end

function var_0_0._btnplayOnClick(arg_4_0)
	if not string.nilorempty(arg_4_0._config.storyIdList) then
		local var_4_0 = string.splitToNumber(arg_4_0._config.storyIdList, "#")
		local var_4_1 = {}

		if not string.nilorempty(arg_4_0._config.levelIdDict) then
			local var_4_2 = string.split(arg_4_0._config.levelIdDict, "|")

			for iter_4_0, iter_4_1 in ipairs(var_4_2) do
				local var_4_3 = string.splitToNumber(iter_4_1, "#")

				var_4_1[var_4_3[1]] = var_4_3[2]
			end
		end

		local var_4_4 = {
			levelIdDict = var_4_1
		}

		var_4_4.isReplay = true

		StoryController.instance:playStories(var_4_0, var_4_4)
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._btnplay = gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "")

	gohelper.addUIClickAudio(arg_5_0._btnplay.gameObject, AudioEnum.UI.play_ui_screenplay_plot_playback)
end

function var_0_0._refreshUI(arg_6_0)
	arg_6_0._txtstorynamecn.text = arg_6_0._config.name
	arg_6_0._txtstorynameen.text = arg_6_0._config.nameEn

	arg_6_0._simagestoryicon:LoadImage(ResUrl.getStorySmallBg(arg_6_0._config.image))

	if arg_6_0._mo.index > 9 then
		arg_6_0._txtid.text = tostring(arg_6_0._mo.index)
	else
		arg_6_0._txtid.text = "0" .. tostring(arg_6_0._mo.index)
	end
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1
	arg_7_0._config = arg_7_1.config

	arg_7_0:_refreshUI()
end

function var_0_0.getAnimator(arg_8_0)
	return arg_8_0._anim
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0._simagestoryicon:UnLoadImage()
end

return var_0_0
