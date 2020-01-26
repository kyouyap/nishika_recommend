import pandas as pd
from datetime import datetime 
auction = pd.read_csv("data/auction.csv")
brand = pd.read_csv("data/brand.csv")
category = pd.read_csv("data/category.csv")
danjobetsu = pd.read_csv("data/danjobetsu.csv")
genre = pd.read_csv("data/genre.csv")
genregroup = pd.read_csv("data/genregroup.csv")
itemshou = pd.read_csv("data/itemshou.csv")
kaiin = pd.read_csv("data/kaiin.csv")
line = pd.read_csv("data/line.csv")
nyuukaoshirase = pd.read_csv("data/nyuuka_oshirase.csv")
rakusatsu = pd.read_csv("data/rakusatsu.csv")
# search_log=pd.read_csv("data/search_log.tsv")
shudounyuusatsu = pd.read_csv("data/shudounyuusatsu.csv")
watchlist = pd.read_csv("data/watchlist.csv")

submission = pd.read_csv("data/sample_submission.csv")
submission = submission.KaiinID.unique()
submission = pd.DataFrame([list(submission)], index=["KaiinID"]).T

auction["CreateDateOrder"] = auction.CreateDate.map(lambda x: x[0:10]).map(
    lambda x: datetime.strptime(x, '%Y-%m-%d'))-datetime.strptime('2019-10-01', '%Y-%m-%d')

watchlist["TourokuDateOrder"] = watchlist.TourokuDate.map(lambda x: x[0:10]).map(
    lambda x: datetime.strptime(x, '%Y-%m-%d'))-datetime.strptime('2019-10-01', '%Y-%m-%d')
watchlist = pd.merge(watchlist, auction, on="AuctionID")

shudounyuusatsu["ShudouNyuusatsuDateOrder"] = shudounyuusatsu.ShudouNyuusatsuDate.map(lambda x: x[0:10]).map(
    lambda x: datetime.strptime(x, '%Y-%m-%d'))-datetime.strptime('2019-10-01', '%Y-%m-%d')
shudounyuusatsu = pd.merge(shudounyuusatsu, auction, on='AuctionID')
order = -7

shudounyuusatsu["Point"] = 1/(order-shudounyuusatsu.CreateDateOrder.map(lambda x: x.days))**0.5/(
    order-shudounyuusatsu.ShudouNyuusatsuDateOrder.map(lambda x: x.days))
watchlist["Point"] = 4/(order-watchlist.CreateDateOrder.map(lambda x: x.days)
                        )**0.5/(order-watchlist.TourokuDateOrder.map(lambda x: x.days))

predict = pd.concat([shudounyuusatsu[["KaiinID", "AuctionID", "Point"]],
                     watchlist[watchlist.SakujoFlag == 1][["KaiinID", "AuctionID", "Point"]]])

predict = predict.groupby(["KaiinID", "AuctionID"]).max()
predict = predict.reset_index()
predict = pd.merge(submission, predict, how="left")
predict = predict.sort_values(
    ["Point", "KaiinID", "AuctionID"], ascending=[False, True, True])

kari = auction[auction.CreateDateOrder.map(
    lambda x:x.days) == order-5].sample(n=20, random_state=0)
addtionaltable = kari["AuctionID"]

num=predict.KaiinID.unique()


for i in range(len(num)):
    
    addtionaltable=pd.DataFrame({"KaiinID":pd.Series([num[i]]*20),"AuctionID":kari["AuctionID"].reset_index(drop=True),"Point":pd.Series([0]*20)})
    
    df1=pd.concat([pd.concat([predict[predict.KaiinID==num[i]],addtionaltable]).reset_index(drop=True)[["KaiinID","AuctionID"]],
           pd.concat([predict[predict.KaiinID==num[i]],addtionaltable]).Point.rank(method='first',ascending=False).reset_index(drop=True)],axis=1)
# .rank(method='first',ascending=False).Point
    if i==0:
        df=df1[(0<df1.Point)&(df1.Point<21)]
    else:
        df=pd.concat([df,df1[(0<df1.Point)&(df1.Point<21)]])
    if i%100==0:
        print(str(i)+"回目")
df[["KaiinID","AuctionID"]].to_csv("submission.csv",index = False)