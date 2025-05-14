module("modules.logic.endofdream.view.EndOfDreamView", package.seeall)

local var_0_0 = class("EndOfDreamView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._golevelitem = gohelper.findChild(arg_1_0.viewGO, "levelitemlist/#go_levelitem")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._levelitemOnClick(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._levelItemList[arg_4_1]

	if EndOfDreamModel.instance:isLevelUnlocked(var_4_0.levelId) then
		arg_4_0:_changeSelectLevel(var_4_0.levelId)
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_beijingtu.jpg"))
	gohelper.setActive(arg_5_0._golevelitem, false)

	arg_5_0._levelItemList = {}
	arg_5_0._selectLevelId = nil
	arg_5_0._selectEpisodeId = nil
	arg_5_0._isHard = false
end

function var_0_0._changeSelectLevel(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0._selectLevelId then
		return
	end

	arg_6_0._selectLevelId = arg_6_1
	arg_6_0._isHard = false
	arg_6_0._selectEpisodeId = EndOfDreamConfig.instance:getEpisodeConfigByLevelId(arg_6_0._selectLevelId, arg_6_0._isHard).id

	arg_6_0:_refreshUI()
end

function var_0_0._changeSelectEpisode(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0._selectEpisodeId then
		return
	end

	arg_7_0._selectEpisodeId = arg_7_1

	local var_7_0, var_7_1 = EndOfDreamConfig.instance:getLevelConfigByEpisodeId(arg_7_1)

	arg_7_0._selectLevelId = var_7_0.id
	arg_7_0._isHard = var_7_1

	arg_7_0:_refreshUI()
end

function var_0_0._changeHard(arg_8_0, arg_8_1)
	if arg_8_1 == arg_8_0._isHard then
		return
	end

	arg_8_0._isHard = arg_8_1
	arg_8_0._selectEpisodeId = EndOfDreamConfig.instance:getEpisodeConfigByLevelId(arg_8_0._selectLevelId, arg_8_0._isHard).id

	arg_8_0:_refreshUI()
end

function var_0_0._setDefaultSelect(arg_9_0)
	local var_9_0 = arg_9_0.viewParam and arg_9_0.viewParam.episodeId
	local var_9_1 = arg_9_0.viewParam and arg_9_0.viewParam.levelId
	local var_9_2 = arg_9_0.viewParam and arg_9_0.viewParam.isHard

	if var_9_0 then
		local var_9_3, var_9_4 = EndOfDreamConfig.instance:getLevelConfigByEpisodeId(var_9_0)

		var_9_1 = var_9_3.id
		var_9_2 = var_9_4
	end

	var_9_2 = var_9_2 or false
	arg_9_0._isHard = var_9_2

	if var_9_1 then
		arg_9_0._selectLevelId = var_9_1
	else
		arg_9_0._selectLevelId = EndOfDreamConfig.instance:getFirstLevelConfig().id
	end

	arg_9_0._selectEpisodeId = EndOfDreamConfig.instance:getEpisodeConfigByLevelId(arg_9_0._selectLevelId, arg_9_0._isHard).id
end

function var_0_0._refreshUI(arg_10_0)
	arg_10_0:_refreshLevel()
	arg_10_0:_refreshInfo()
end

function var_0_0._refreshLevel(arg_11_0)
	local var_11_0 = EndOfDreamConfig.instance:getLevelConfigList()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = iter_11_1.id
		local var_11_2 = arg_11_0._levelItemList[iter_11_0]

		if not var_11_2 then
			var_11_2 = arg_11_0:getUserDataTb_()
			var_11_2.index = iter_11_0
			var_11_2.go = gohelper.cloneInPlace(arg_11_0._golevelitem, "item" .. iter_11_0)
			var_11_2.goselect = gohelper.findChild(var_11_2.go, "go_selected")
			var_11_2.txtselect = gohelper.findChildText(var_11_2.go, "go_selected/txt_itemcn2")
			var_11_2.gounselect = gohelper.findChild(var_11_2.go, "go_unselected")
			var_11_2.txtunselect = gohelper.findChildText(var_11_2.go, "go_unselected/txt_itemcn1")
			var_11_2.golock = gohelper.findChild(var_11_2.go, "go_locked")
			var_11_2.btnclick = gohelper.findChildButtonWithAudio(var_11_2.go, "btn_click")

			var_11_2.btnclick:AddClickListener(arg_11_0._levelitemOnClick, arg_11_0, var_11_2.index)
			table.insert(arg_11_0._levelItemList, var_11_2)
		end

		var_11_2.levelId = var_11_1
		var_11_2.txtselect.text = iter_11_1.name
		var_11_2.txtunselect.text = iter_11_1.name

		local var_11_3 = EndOfDreamModel.instance:isLevelUnlocked(var_11_1)

		gohelper.setActive(var_11_2.goselect, var_11_1 == arg_11_0._selectLevelId)
		gohelper.setActive(var_11_2.gounselect, var_11_1 ~= arg_11_0._selectLevelId)
		gohelper.setActive(var_11_2.golock, not var_11_3)
		gohelper.setActive(var_11_2.go, true)
	end

	for iter_11_2 = #var_11_0 + 1, #arg_11_0._levelItemList do
		local var_11_4 = arg_11_0._levelItemList[iter_11_2]

		gohelper.setActive(var_11_4.go, false)
	end
end

function var_0_0._refreshInfo(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0:_setDefaultSelect()
	arg_13_0:_refreshUI()
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0._levelItemList) do
		iter_15_1.btnclick:RemoveClickListener()
	end
end

return var_0_0
