module("modules.logic.explore.view.ExploreBonusSceneRecordView", package.seeall)

local var_0_0 = class("ExploreBonusSceneRecordView", BaseView)
local var_0_1 = 8

function var_0_0._setContentPaddingTop(arg_1_0, arg_1_1)
	arg_1_0._vLayoutGroup.padding.top = arg_1_1
end

function var_0_0._updateContentPaddingTop(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._originalPaddingTop

	if arg_2_1 then
		var_2_0 = var_2_0 + var_0_1
	end

	arg_2_0:_setContentPaddingTop(var_2_0)
end

function var_0_0.onInitView(arg_3_0)
	arg_3_0._btnclose = gohelper.findChildButtonWithAudio(arg_3_0.viewGO, "#btn_close")
	arg_3_0._item = gohelper.findChild(arg_3_0.viewGO, "mask/Scroll View/Viewport/Content/#go_chatitem")
	arg_3_0._itemContent = gohelper.findChild(arg_3_0.viewGO, "mask/Scroll View/Viewport/Content")
	arg_3_0._simageicon = gohelper.findChildSingleImage(arg_3_0.viewGO, "#simage_icon")
	arg_3_0._vLayoutGroup = arg_3_0._itemContent:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
	arg_3_0._originalPaddingTop = arg_3_0._vLayoutGroup.padding.top
	arg_3_0._tmpMarkTopTextList = {}
	arg_3_0._tmpMarkTopTextListList = {}
end

function var_0_0.addEvents(arg_4_0)
	arg_4_0._btnclose:AddClickListener(arg_4_0.closeThis, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0._btnclose:RemoveClickListener()
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.chapterId
	local var_6_1 = ExploreSimpleModel.instance:getChapterMo(var_6_0).bonusScene
	local var_6_2, var_6_3 = next(var_6_1)
	local var_6_4 = ExploreConfig.instance:getDialogueConfig(var_6_2)
	local var_6_5 = {}
	local var_6_6

	for iter_6_0, iter_6_1 in ipairs(var_6_3) do
		local var_6_7 = var_6_4[iter_6_0]

		if var_6_7 then
			local var_6_8 = {
				desc = var_6_7.desc
			}

			if not string.nilorempty(var_6_7.bonusButton) then
				var_6_8.options = string.split(var_6_7.bonusButton, "|")
				var_6_8.index = iter_6_1
			end

			table.insert(var_6_5, var_6_8)

			if not string.nilorempty(var_6_7.picture) then
				var_6_6 = var_6_7.picture
			end
		end
	end

	if not string.nilorempty(var_6_6) then
		arg_6_0._simageicon:LoadImage(ResUrl.getExploreBg("file/" .. var_6_6))
	end

	gohelper.CreateObjList(arg_6_0, arg_6_0.onCreateItem, var_6_5, arg_6_0._itemContent, arg_6_0._item)
end

function var_0_0.onCreateItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = gohelper.findChildTextMesh(arg_7_1, "info")
	local var_7_1 = gohelper.findChild(arg_7_1, "bg")

	gohelper.setActive(var_7_0, arg_7_2.desc)
	gohelper.setActive(var_7_1, arg_7_2.options)

	if arg_7_2.desc then
		local var_7_2 = arg_7_0._tmpMarkTopTextList[arg_7_3]

		if not var_7_2 then
			var_7_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_0.gameObject, TMPMarkTopText)

			var_7_2:setTopOffset(0, -5.2)
			var_7_2:setLineSpacing(15)

			arg_7_0._tmpMarkTopTextList[arg_7_3] = var_7_2
		else
			var_7_2:reInitByCmp(var_7_0)
		end

		var_7_2:setData(arg_7_2.desc)
	end

	if arg_7_3 == 1 then
		arg_7_0:_updateContentPaddingTop(arg_7_0._tmpMarkTopTextList[arg_7_3]:isContainsMarkTop())
	end

	if arg_7_2.options then
		for iter_7_0 = 1, 3 do
			local var_7_3 = gohelper.findChildTextMesh(var_7_1, "txt" .. iter_7_0)
			local var_7_4 = gohelper.findChild(var_7_1, "txt" .. iter_7_0 .. "/play")

			arg_7_0._tmpMarkTopTextListList[arg_7_3] = arg_7_0._tmpMarkTopTextListList[arg_7_3] or {}

			local var_7_5 = arg_7_0._tmpMarkTopTextListList[arg_7_3][iter_7_0]

			if not var_7_5 then
				var_7_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_3.gameObject, TMPMarkTopText)

				var_7_5:setTopOffset(0, -5.5)
				var_7_5:setLineSpacing(7)

				arg_7_0._tmpMarkTopTextListList[arg_7_3][iter_7_0] = var_7_5
			else
				var_7_5:reInitByCmp(var_7_3)
			end

			if arg_7_2.options[iter_7_0] then
				var_7_5:setData(arg_7_2.options[iter_7_0])
				gohelper.setActive(var_7_4, arg_7_2.index == iter_7_0)
				SLFramework.UGUI.GuiHelper.SetColor(var_7_3, arg_7_2.index == iter_7_0 and "#445D42" or "#3D3939")
			else
				gohelper.setActive(var_7_3, false)
			end
		end
	end
end

function var_0_0.onClickModalMask(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0.onClose(arg_9_0)
	GameUtil.onDestroyViewMemberList(arg_9_0, "_tmpMarkTopTextList")

	if arg_9_0._tmpMarkTopTextListList then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._tmpMarkTopTextListList) do
			for iter_9_2, iter_9_3 in pairs(iter_9_1) do
				iter_9_3:onDestroyView()
			end
		end

		arg_9_0._tmpMarkTopTextListList = nil
	end

	arg_9_0._simageicon:UnLoadImage()
end

return var_0_0
