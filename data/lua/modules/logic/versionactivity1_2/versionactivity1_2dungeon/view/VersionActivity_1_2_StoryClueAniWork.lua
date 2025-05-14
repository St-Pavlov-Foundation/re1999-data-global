module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_StoryClueAniWork", package.seeall)

local var_0_0 = class("VersionActivity_1_2_StoryClueAniWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._signObjList = arg_1_1
	arg_1_0._viewClass = arg_1_2
	arg_1_0._index = arg_1_3
	arg_1_0._clueId = arg_1_4

	arg_1_0:_buildFlow()
end

function var_0_0._buildFlow(arg_2_0)
	arg_2_0._aniFlow = FlowSequence.New()

	local var_2_0 = 100

	arg_2_0._tweenValue = {}

	local var_2_1 = arg_2_0._viewClass._gomask
	local var_2_2 = var_2_1.transform
	local var_2_3 = gohelper.findChild(arg_2_0._viewClass.viewGO, "root").transform

	var_0_0.lastNoteId = 0

	for iter_2_0 = 1, #arg_2_0._signObjList do
		local var_2_4 = arg_2_0._signObjList[iter_2_0]

		for iter_2_1, iter_2_2 in ipairs(var_2_4) do
			local var_2_5 = iter_2_2.transform
			local var_2_6 = recthelper.getWidth(var_2_5)
			local var_2_7 = var_2_6 / var_2_0

			recthelper.setWidth(var_2_5, 0)

			local var_2_8 = var_2_5.parent.parent.gameObject.transform
			local var_2_9 = var_2_8.name

			if var_0_0.lastNoteId == 0 then
				-- block empty
			elseif var_0_0.lastNoteId ~= var_2_9 then
				arg_2_0._aniFlow:addWork(WorkWaitSeconds.New(0.16))
				arg_2_0._aniFlow:addWork(TweenWork.New({
					from = 1,
					type = "DOFadeCanvasGroup",
					to = 0,
					t = 0.3,
					go = var_2_1
				}))
			end

			if iter_2_1 == 1 then
				local var_2_10 = gohelper.findChild(var_2_8.gameObject, "title/go_titleNormal")
				local var_2_11 = recthelper.rectToRelativeAnchorPos(var_2_10.transform.position, arg_2_0._viewClass.viewGO.transform)
				local var_2_12 = -var_2_11.x * 1.5 - 200
				local var_2_13 = -var_2_11.y * 1.5 + 80
				local var_2_14 = FlowParallel.New()

				var_2_14:addWork(TweenWork.New({
					toz = 1,
					type = "DOScale",
					tox = 1.5,
					toy = 1.5,
					t = 0.3,
					tr = var_2_3
				}))
				var_2_14:addWork(TweenWork.New({
					type = "DOAnchorPos",
					t = 0.3,
					tr = var_2_3,
					tox = var_2_12,
					toy = var_2_13
				}))
				arg_2_0._aniFlow:addWork(var_2_14)

				if var_0_0.lastNoteId ~= var_2_9 then
					arg_2_0._aniFlow:addWork(FunctionWork.New(function()
						recthelper.setWidth(var_2_2, 5200)
						recthelper.setHeight(var_2_2, 2500)
						gohelper.setActive(var_2_1, true)
					end))

					local var_2_15 = FlowParallel.New()
					local var_2_16 = (gohelper.findChildText(var_2_5.parent.gameObject, ""):GetPreferredValues().y - 112) * 1.5
					local var_2_17 = 1250 + var_2_16

					var_2_15:addWork(FunctionWork.New(function()
						recthelper.setAnchorY(var_2_2, 0 - var_2_16 / 2)
					end))
					var_2_15:addWork(TweenWork.New({
						type = "DOSizeDelta",
						tox = 2600,
						t = 0.6,
						tr = var_2_2,
						toy = var_2_17
					}))
					var_2_15:addWork(TweenWork.New({
						from = 0,
						type = "DOFadeCanvasGroup",
						to = 1,
						t = 0.6,
						go = var_2_1
					}))
					arg_2_0._aniFlow:addWork(var_2_15)
				end
			end

			var_0_0.lastNoteId = var_2_9

			arg_2_0._aniFlow:addWork(VersionActivity_1_2_StoryClueLineWork.New(var_2_5, var_2_6, var_2_7, arg_2_0._clueId))

			if iter_2_1 == #var_2_4 then
				arg_2_0._aniFlow:addWork(WorkWaitSeconds.New(0.6))
			end

			table.insert(arg_2_0._tweenValue, {
				tr = var_2_5,
				to = var_2_6
			})
		end
	end

	var_0_0.lastNoteId = 0

	arg_2_0._aniFlow:addWork(TweenWork.New({
		from = 1,
		type = "DOFadeCanvasGroup",
		to = 0,
		t = 0.3,
		go = var_2_1
	}))
	arg_2_0._aniFlow:addWork(TweenWork.New({
		type = "DOAnchorPos",
		tox = -556,
		toy = 466,
		t = 0.3,
		tr = var_2_3
	}))

	local var_2_18 = arg_2_0._viewClass._gocollectNote.transform:GetChild(arg_2_0._index - 1).gameObject

	arg_2_0._aniFlow:addWork(FunctionWork.New(function()
		gohelper.setActive(var_2_18, true)
	end))

	local var_2_19 = gohelper.findChild(var_2_18, VersionActivity_1_2_StoryCollectView._signTypeName[arg_2_0._clueId]).transform
	local var_2_20 = recthelper.getWidth(var_2_19)
	local var_2_21 = var_2_20 / var_2_0

	recthelper.setWidth(var_2_19, 0)
	arg_2_0._aniFlow:addWork(VersionActivity_1_2_StoryClueLineWork.New(var_2_19, var_2_20, var_2_21, arg_2_0._clueId))
	arg_2_0._aniFlow:addWork(WorkWaitSeconds.New(1))
	table.insert(arg_2_0._tweenValue, {
		tr = var_2_19,
		to = var_2_20,
		collectNoteItem = var_2_18
	})
end

function var_0_0.onStart(arg_6_0)
	arg_6_0._aniFlow:registerDoneListener(arg_6_0._onAniFlowDone, arg_6_0)
	arg_6_0._aniFlow:start()
end

function var_0_0._onAniFlowDone(arg_7_0)
	if arg_7_0._aniFlow then
		arg_7_0._aniFlow:unregisterDoneListener(arg_7_0._onAniFlowDone, arg_7_0)
		arg_7_0._aniFlow:destroy()

		arg_7_0._aniFlow = nil
	end

	arg_7_0:onDone(true)
end

function var_0_0.clearWork(arg_8_0)
	if arg_8_0._aniFlow then
		arg_8_0._aniFlow:unregisterDoneListener(arg_8_0._onAniFlowDone, arg_8_0)
		arg_8_0._aniFlow:destroy()

		arg_8_0._aniFlow = nil
	end
end

return var_0_0
