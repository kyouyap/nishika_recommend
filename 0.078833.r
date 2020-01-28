library(data.table)
library(lightgbm)


submission = fread("data/sample_submission.csv", col.names=c("KaiinID", "AuctionID"))
submission = unique(submission[, .(KaiinID)], by = NULL)

auction = fread("data/auction.csv", col.names=c("AuctionID", "ShouhinShubetsuID", "ShouhinID", "SaishuppinKaisuu", "ConditionID", "BrandID", "GenreID", "GenreGroupID", "LineID", "ColorID", "DanjobetsuID", "SankouKakaku", "CreateDate"))
auction$CreateDateOrder = as.double(as.Date(substring(auction$CreateDate, 1, 10))-as.Date("2019-10-01"))

watchlist = fread("data/watchlist.csv", col.names=c("KaiinID", "AuctionID", "TourokuDate", "SakujoFlag"))
watchlist$TourokuDateOrder = as.double(as.Date(substring(watchlist$TourokuDate, 1, 10))-as.Date("2019-10-01"))
watchlist = merge(watchlist, auction, by = "AuctionID")

shudounyuusatsu = fread("data/shudounyuusatsu.csv", col.names=c("AuctionID", "KaiinID", "ShudouNyuusatsuDate", "Kingaku", "Suuryou", "SokketsuFlag", "SakujoFlag"))
shudounyuusatsu$ShudouNyuusatsuDateOrder = as.double(as.Date(substring(shudounyuusatsu$ShudouNyuusatsuDate, 1, 10))-as.Date("2019-10-01"))
shudounyuusatsu = merge(shudounyuusatsu, auction, by = "AuctionID")

rakusatsu = fread("data/rakusatsu.csv", col.names=c("AuctionID", "KaiinID", "RakusatsuDate", "Kingaku", "Suuryou", "SakujoFlag"))
rakusatsu$RakusatsuDateOrder = as.double(as.Date(substring(rakusatsu$RakusatsuDate, 1, 10)) - as.Date("2019-10-01"))
rakusatsu = merge(rakusatsu, submission, by = "KaiinID")
rakusatsu = merge(rakusatsu, auction, by = "AuctionID")




DateOrder = -7

getdf = function(inputsubmission, inputwatchlist, inputshudounyuusatsu, inputrakusatsu, inputDateOrder)
{
    df = unique(rbind(inputwatchlist[, .(KaiinID, ShouhinID)], inputshudounyuusatsu[, .(KaiinID, ShouhinID)]), by = NULL)
    df = merge(df, auction[, .(AuctionID, ShouhinID)], by = "ShouhinID")
    df = unique(df[, .(KaiinID, AuctionID)], by=NULL)

    df = merge(df, inputsubmission, by = "KaiinID")
    df = merge(df, auction[, .(AuctionID, ShouhinShubetsuID, ShouhinID, SaishuppinKaisuu, ConditionID, BrandID, GenreID, GenreGroupID, LineID, DanjobetsuID, CreateDateOrder = inputDateOrder - CreateDateOrder)], by = "AuctionID")

    inputwatchlist[, inputTourokuDateOrder := inputDateOrder - TourokuDateOrder]
    df = merge(df, inputwatchlist[, .(
        TourokuCount = .N
        , TourokuDateOrdermin = min(inputTourokuDateOrder)
        , TourokuDateOrdermax = max(inputTourokuDateOrder)
        , TourokuDateOrdermaxmindiff = max(inputTourokuDateOrder) - min(inputTourokuDateOrder)
        , watchSakujo = max(SakujoFlag[TourokuDateOrder == max(TourokuDateOrder)])
    ), .(KaiinID, AuctionID)], by = c("KaiinID", "AuctionID"), all.x = T)
    df = merge(df, inputwatchlist[, .(AuctionWatchedCount = .N), .(AuctionID)], by = c("AuctionID"), all.x = T)
    df = merge(df, inputwatchlist[, .(ShouhinWatchedCount = .N), .(ShouhinID)], by = c("ShouhinID"), all.x = T)
    df = merge(df, inputwatchlist[, .(BrandWatchedCount = .N), .(BrandID)], by = c("BrandID"), all.x = T)
    df = merge(df, inputwatchlist[, .(LineWatchedCount = .N), .(LineID)], by = c("LineID"), all.x = T)
    df = merge(df, inputwatchlist[, .(ShouhinKaiinWatchCount = .N), .(KaiinID, ShouhinID)], by = c("KaiinID", "ShouhinID"), all.x = T)
    df = merge(df, inputwatchlist[, .(BrandKaiinWatchCount = .N), .(KaiinID, BrandID)], by = c("KaiinID", "BrandID"), all.x = T)
    df = merge(df, inputwatchlist[, .(GenreGroupKaiinWatchCount = .N), .(KaiinID, GenreGroupID)], by = c("KaiinID", "GenreGroupID"), all.x = T)
    df = merge(df, inputwatchlist[, .(LineKaiinWatchCount = .N), .(KaiinID, LineID)], by = c("KaiinID", "LineID"), all.x = T)

    inputshudounyuusatsu[, inputShudouNyuusatsuDateOrder := inputDateOrder - ShudouNyuusatsuDateOrder]
    df = merge(df, inputshudounyuusatsu[, .(
        ShudouNyuusatsuCount = .N
        , ShudouNyuusatsuDateOrdermin = min(inputShudouNyuusatsuDateOrder)
        , ShudouNyuusatsuDateOrdermax = max(inputShudouNyuusatsuDateOrder)
        , ShudouNyuusatsuDatemaxmindiff = max(inputShudouNyuusatsuDateOrder) - min(inputShudouNyuusatsuDateOrder)
    ), .(KaiinID, AuctionID)], by = c("KaiinID", "AuctionID"), all.x = T)
    df = merge(df, inputshudounyuusatsu[, .(AuctionNyuudstsuCount = .N), .(AuctionID)], by = c("AuctionID"), all.x = T)
    df = merge(df, inputshudounyuusatsu[, .(ShouhinNyuusatsuCount = .N), .(ShouhinID)], by = c("ShouhinID"), all.x = T)
    df = merge(df, inputshudounyuusatsu[, .(BrandNyuudstsuCount = .N), .(BrandID)], by = c("BrandID"), all.x = T)
    df = merge(df, inputshudounyuusatsu[, .(LineNyuudstsuCount = .N), .(LineID)], by = c("LineID"), all.x = T)
    df = merge(df, inputshudounyuusatsu[, .(ShouhinKaiinNyuusatsuCount = .N), .(KaiinID, ShouhinID)], by = c("KaiinID", "ShouhinID"), all.x = T)
    df = merge(df, inputshudounyuusatsu[, .(BrandKaiinNyuusatsuCount = .N), .(KaiinID, BrandID)], by = c("KaiinID", "BrandID"), all.x = T)
    df = merge(df, inputshudounyuusatsu[, .(GenreGroupKaiinNyuusatuCount = .N), .(KaiinID, GenreGroupID)], by = c("KaiinID", "GenreGroupID"), all.x = T)
    df = merge(df, inputshudounyuusatsu[, .(LineKaiinNyuusatuCount = .N), .(KaiinID, LineID)], by = c("KaiinID", "LineID"), all.x = T)

    df = df[, -c("ShouhinShubetsuID", "ShouhinID", "BrandID", "GenreID", "GenreGroupID", "LineID")]
    df[is.na(df)] = -1

    df
}

train_df = NULL
for (i in 1:4)
{
    print(i)
    train_ref_df = rbind(
        watchlist[TourokuDateOrder >= DateOrder - 7 * i & TourokuDateOrder < DateOrder - 7 * i + 7, .(KaiinID, AuctionID, tag = 1)]
        , shudounyuusatsu[ShudouNyuusatsuDateOrder >= DateOrder - 7 * i & ShudouNyuusatsuDateOrder < DateOrder - 7 * i + 7, .(KaiinID, AuctionID, tag = 2)]
    )
    train_ref_df = train_ref_df[, .(tag = max(tag)), .(KaiinID, AuctionID)]
    train_KaiinID = unique(train_ref_df[, .(KaiinID)], by = NULL)

    train_watchlist = watchlist[TourokuDateOrder < DateOrder - 7 * i]
    train_shudounyuusatsu = shudounyuusatsu[ShudouNyuusatsuDateOrder < DateOrder - 7 * i]
    train_rakusatsu = rakusatsu[RakusatsuDateOrder < DateOrder - 7 * i]


    train_df_child = getdf(train_KaiinID, train_watchlist, train_shudounyuusatsu, train_rakusatsu, DateOrder - 7 * i)
    train_df_child = merge(train_df_child, watchlist[TourokuDateOrder >= DateOrder - 7 * i & TourokuDateOrder < DateOrder - 7 * i + 7, .(watchtag = 1), .(KaiinID, AuctionID)], by = c("KaiinID", "AuctionID"), all.x = T)
    train_df_child = merge(train_df_child, shudounyuusatsu[ShudouNyuusatsuDateOrder >= DateOrder - 7 * i & ShudouNyuusatsuDateOrder < DateOrder - 7 * i + 7, .(nyuusatsutag = 1), .(KaiinID, AuctionID)], by = c("KaiinID", "AuctionID"), all.x = T)
    train_df_child[is.na(train_df_child)] = 0
    train_df_child = cbind(train_df_child[, .(KaiinID, AuctionID, watchtag, nyuusatsutag)], train_df_child[, -c("KaiinID", "AuctionID", "watchtag", "nyuusatsutag")])
    train_df = rbind(train_df, train_df_child)
}

watch_model = lgb.train(data = lgb.Dataset(data.matrix(train_df[, c(-1:-4)]), label = train_df$watchtag), objective = "binary", nround = 500, learning_rate = 0.01, max_depth = 6, num_leaves = 127, verbosity = -1,random_seed=0)
nyuusatsu_model = lgb.train(data = lgb.Dataset(data.matrix(train_df[, c(-1:-4)]), label = train_df$nyuusatsutag), objective = "binary", nround = 500, learning_rate = 0.01, max_depth = 6, num_leaves = 127, verbosity = -1,random_seed=0)




test_df = getdf(submission, watchlist, shudounyuusatsu, rakusatsu, DateOrder)
test_df = cbind(test_df[, .(KaiinID, AuctionID, watchtag = -1, nyuusatsutag = -1)], test_df[, -c("KaiinID", "AuctionID")])
pred = test_df[, .(KaiinID, AuctionID, watch_point = predict(watch_model, data.matrix(test_df[, c(-1:-4)])), nyuusatsu_point = predict(nyuusatsu_model, data.matrix(test_df[, c(-1:-4)])))]
pred = pred[, .(KaiinID, AuctionID, point = 0.5 * watch_point + 0.5 * nyuusatsu_point)]
pred = pred[, .(point = max(point)), .(KaiinID, AuctionID)]
pred = pred[order(-point)]
pred = merge(pred, submission, by = "KaiinID", all.y = T)

set.seed(0)
additional_df = auction[CreateDateOrder == DateOrder - 5, .(AuctionID =  sample(AuctionID, 20))]
pred = pred[, .(PredOrder = 1:20, AuctionID = c(AuctionID[!is.na(AuctionID)], additional_df$AuctionID)[1:20]), .(KaiinID)]

write.csv(pred[, .(KaiinID = KaiinID, AuctionID = AuctionID)], "result.csv", row.names = F, quote = F)
