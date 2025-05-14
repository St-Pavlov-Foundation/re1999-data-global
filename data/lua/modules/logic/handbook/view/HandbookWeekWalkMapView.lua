module("modules.logic.handbook.view.HandbookWeekWalkMapView", package.seeall)

local var_0_0 = class("HandbookWeekWalkMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._goleftarrow = gohelper.findChild(arg_1_0.viewGO, "#go_leftarrow")
	arg_1_0._gorightarrow = gohelper.findChild(arg_1_0.viewGO, "#go_rightarrow")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.goweekList = {}

	for iter_4_0 = 1, 3 do
		local var_4_0 = arg_4_0:getUserDataTb_()

		var_4_0.go = gohelper.findChild(arg_4_0.viewGO, "weekwalkContainer/#go_week" .. iter_4_0)
		var_4_0.name = gohelper.findChildText(var_4_0.go, "txt_name")
		var_4_0.click = gohelper.getClickWithAudio(var_4_0.go)

		var_4_0.click:AddClickListener(arg_4_0.onClickGoWeek, arg_4_0, iter_4_0)
		table.insert(arg_4_0.goweekList, var_4_0)
	end

	arg_4_0.leftClick = gohelper.getClickWithAudio(arg_4_0._goleftarrow)
	arg_4_0.rightClick = gohelper.getClickWithAudio(arg_4_0._gorightarrow)

	arg_4_0.leftClick:AddClickListener(arg_4_0.leftPageOnClick, arg_4_0)
	arg_4_0.rightClick:AddClickListener(arg_4_0.rightPageOnClick, arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getHandbookCharacterIcon("full/bg111"))
end

function var_0_0.onClickGoWeek(arg_5_0, arg_5_1)
	ViewMgr.instance:openView(ViewName.HandbookWeekWalkView, arg_5_0:getMapCoByPageNumAndIndex(arg_5_0.pageNum, arg_5_1))
end

function var_0_0.leftPageOnClick(arg_6_0)
	if arg_6_0.pageNum <= 1 then
		return
	end

	arg_6_0.pageNum = arg_6_0.pageNum - 1

	arg_6_0:refreshMapElements(arg_6_0.pageNum)
end

function var_0_0.rightPageOnClick(arg_7_0)
	if arg_7_0.pageNum >= arg_7_0.maxPageNum then
		return
	end

	arg_7_0.pageNum = arg_7_0.pageNum + 1

	arg_7_0:refreshMapElements(arg_7_0.pageNum)
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:onOpen()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.pageNum = 1
	arg_9_0.pageSize = 3
	arg_9_0.maxPageNum = math.ceil(#lua_weekwalk.configList / 3)

	arg_9_0:refreshMapElements(arg_9_0.pageNum)
end

function var_0_0.refreshMapElements(arg_10_0, arg_10_1)
	arg_10_0.mapCoList = arg_10_0:getMapCoListByPageNum(arg_10_1)

	local var_10_0 = #arg_10_0.mapCoList

	for iter_10_0 = 1, var_10_0 do
		arg_10_0.goweekList[iter_10_0].name.text = arg_10_0.mapCoList[iter_10_0].name

		gohelper.setActive(arg_10_0.goweekList[iter_10_0].go, true)
	end

	for iter_10_1 = var_10_0 + 1, 3 do
		gohelper.setActive(arg_10_0.goweekList[iter_10_1].go, false)
	end

	gohelper.setActive(arg_10_0._goleftarrow, arg_10_0.pageNum > 1)
	gohelper.setActive(arg_10_0._gorightarrow, arg_10_0.pageNum < arg_10_0.maxPageNum)
end

function var_0_0.getMapCoListByPageNum(arg_11_0, arg_11_1)
	local var_11_0 = (arg_11_1 - 1) * 3
	local var_11_1 = {}
	local var_11_2

	for iter_11_0 = 1, 3 do
		local var_11_3 = lua_weekwalk.configList[var_11_0 + iter_11_0]

		if not var_11_3 then
			break
		end

		table.insert(var_11_1, var_11_3)
	end

	return var_11_1
end

function var_0_0.getMapCoByPageNumAndIndex(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = (arg_12_1 - 1) * 3

	return lua_weekwalk.configList[var_12_0 + arg_12_2]
end

function var_0_0.onClose(arg_13_0)
	arg_13_0.leftClick:RemoveClickListener()
	arg_13_0.rightClick:RemoveClickListener()
	arg_13_0._simagebg:UnLoadImage()

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.goweekList) do
		iter_13_1.click:RemoveClickListener()
	end
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
