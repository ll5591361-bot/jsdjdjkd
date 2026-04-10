$jsonContent = Get-Content 'words-data.json' -Raw -Encoding UTF8 | ConvertFrom-Json

$newWords = @(
    @{word="ski"; phonetic="/skiː/"; meaning="v. 滑雪"; sentence="I like to ski in winter."; sentencePhonetic="/aɪ laɪk tuː skiː ɪn ˈwɪntə(r)/"; letters=@("S","K","I"); category="sports"; pos="verb"},
    @{word="skate"; phonetic="/skeɪt/"; meaning="v. 滑冰"; sentence="We skate on the ice rink."; sentencePhonetic="/wiː skeɪt ɒn ðə aɪs rɪŋk/"; letters=@("S","K","A","T","E"); category="sports"; pos="verb"},
    @{word="surf"; phonetic="/sɜːf/"; meaning="v. 冲浪"; sentence="He loves to surf big waves."; sentencePhonetic="/hiː lʌvz tuː sɜːf bɪɡ weɪvz/"; letters=@("S","U","R","F"); category="sports"; pos="verb"},
    @{word="dive"; phonetic="/daɪv/"; meaning="v. 跳水"; sentence="She can dive from the high board."; sentencePhonetic="/ʃiː kæn daɪv frɒm ðə haɪ bɔːd/"; letters=@("D","I","V","E"); category="sports"; pos="verb"},
    @{word="climb"; phonetic="/klaɪm/"; meaning="v. 攀登"; sentence="They climb mountains on weekends."; sentencePhonetic="/ðeɪ klaɪm ˈmaʊntɪnz ɒn ˈwiːkendz/"; letters=@("C","L","I","M","B"); category="sports"; pos="verb"},
    @{word="cycle"; phonetic="/ˈsaɪkl/"; meaning="v. 骑自行车"; sentence="I cycle to work every day."; sentencePhonetic="/aɪ ˈsaɪkl tuː wɜːk ˈevri deɪ/"; letters=@("C","Y","C","L","E"); category="sports"; pos="verb"},
    @{word="hike"; phonetic="/haɪk/"; meaning="v. 徒步"; sentence="We hike in the mountains."; sentencePhonetic="/wiː haɪk ɪn ðə ˈmaʊntɪnz/"; letters=@("H","I","K","E"); category="sports"; pos="verb"},
    @{word="sprint"; phonetic="/sprɪnt/"; meaning="v. 短跑"; sentence="He will sprint the last 100 meters."; sentencePhonetic="/hiː wɪl sprɪnt ðə lɑːst 100 ˈmiːtəz/"; letters=@("S","P","R","I","N","T"); category="sports"; pos="verb"},
    @{word="marathon"; phonetic="/ˈmærəθən/"; meaning="n. 马拉松"; sentence="She is training for a marathon."; sentencePhonetic="/ʃiː ɪz ˈtreɪnɪŋ fɔː(r) ə ˈmærəθən/"; letters=@("M","A","R","A","T","H","O","N"); category="sports"; pos="noun"},
    @{word="relay"; phonetic="/ˈriːleɪ/"; meaning="n. 接力赛"; sentence="Our team won the relay race."; sentencePhonetic="/ˈaʊə(r) tiːm wʌn ðə ˈriːleɪ reɪs/"; letters=@("R","E","L","A","Y"); category="sports"; pos="noun"},
    @{word="throw"; phonetic="/θrəʊ/"; meaning="v. 投掷"; sentence="He can throw the ball far."; sentencePhonetic="/hiː kæn θrəʊ ðə bɔːl fɑː(r)/"; letters=@("T","H","R","O","W"); category="sports"; pos="verb"},
    @{word="catch"; phonetic="/kætʃ/"; meaning="v. 接住"; sentence="Catch the ball with both hands."; sentencePhonetic="/kætʃ ðə bɔːl wɪð bəʊθ hændz/"; letters=@("C","A","T","C","H"); category="sports"; pos="verb"},
    @{word="kick"; phonetic="/kɪk/"; meaning="v. 踢"; sentence="He kicked the ball into the goal."; sentencePhonetic="/hiː kɪkt ðə bɔːl ˈɪntuː ðə ɡəʊl/"; letters=@("K","I","C","K"); category="sports"; pos="verb"},
    @{word="pass"; phonetic="/pɑːs/"; meaning="v. 传球"; sentence="Pass the ball to your teammate."; sentencePhonetic="/pɑːs ðə bɔːl tuː jɔː(r) ˈtiːmmeɪt/"; letters=@("P","A","S","S"); category="sports"; pos="verb"},
    @{word="shoot"; phonetic="/ʃuːt/"; meaning="v. 射门，投篮"; sentence="He shoots and scores!"; sentencePhonetic="/hiː ʃuːts ənd skɔːz/"; letters=@("S","H","O","O","T"); category="sports"; pos="verb"},
    @{word="defend"; phonetic="/dɪˈfend/"; meaning="v. 防守"; sentence="We must defend our goal."; sentencePhonetic="/wiː mʌst dɪˈfend ˈaʊə(r) ɡəʊl/"; letters=@("D","E","F","E","N","D"); category="sports"; pos="verb"},
    @{word="attack"; phonetic="/əˈtæk/"; meaning="v. 进攻"; sentence="The team will attack soon."; sentencePhonetic="/ðə tiːm wɪl əˈtæk suːn/"; letters=@("A","T","T","A","C","K"); category="sports"; pos="verb"},
    @{word="block"; phonetic="/blɒk/"; meaning="v. 阻挡"; sentence="He blocked the shot."; sentencePhonetic="/hiː blɒkt ðə ʃɒt/"; letters=@("B","L","O","C","K"); category="sports"; pos="verb"},
    @{word="dribble"; phonetic="/ˈdrɪbl/"; meaning="v. 运球"; sentence="He can dribble past defenders."; sentencePhonetic="/hiː kæn ˈdrɪbl pɑːst dɪˈfendəz/"; letters=@("D","R","I","B","B","L","E"); category="sports"; pos="verb"},
    @{word="serve"; phonetic="/sɜːv/"; meaning="v. 发球"; sentence="It's your turn to serve."; sentencePhonetic="/ɪts jɔː(r) tɜːn tuː sɜːv/"; letters=@("S","E","R","V","E"); category="sports"; pos="verb"},
    @{word="spike"; phonetic="/spaɪk/"; meaning="v. 扣球"; sentence="She spiked the ball hard."; sentencePhonetic="/ʃiː spaɪkt ðə bɔːl hɑːd/"; letters=@("S","P","I","K","E"); category="sports"; pos="verb"},
    @{word="paddle"; phonetic="/ˈpædl/"; meaning="n. 球拍"; sentence="Use the paddle to hit the ball."; sentencePhonetic="/juːz ðə ˈpædl tuː hɪt ðə bɔːl/"; letters=@("P","A","D","D","L","E"); category="sports"; pos="noun"},
    @{word="racket"; phonetic="/ˈrækɪt/"; meaning="n. 球拍"; sentence="I need a new tennis racket."; sentencePhonetic="/aɪ niːd ə njuː ˈtenɪs ˈrækɪt/"; letters=@("R","A","C","K","E","T"); category="sports"; pos="noun"},
    @{word="bat"; phonetic="/bæt/"; meaning="n. 球棒"; sentence="He hit the ball with the bat."; sentencePhonetic="/hiː hɪt ðə bɔːl wɪð ðə bæt/"; letters=@("B","A","T"); category="sports"; pos="noun"},
    @{word="net"; phonetic="/net/"; meaning="n. 网"; sentence="The ball went over the net."; sentencePhonetic="/ðə bɔːl went ˈəʊvə(r) ðə net/"; letters=@("N","E","T"); category="sports"; pos="noun"},
    @{word="hoop"; phonetic="/huːp/"; meaning="n. 篮筐"; sentence="He shot the ball through the hoop."; sentencePhonetic="/hiː ʃɒt ðə bɔːl θruː ðə huːp/"; letters=@("H","O","O","P"); category="sports"; pos="noun"},
    @{word="helmet"; phonetic="/ˈhelmɪt/"; meaning="n. 头盔"; sentence="Always wear a helmet when cycling."; sentencePhonetic="/ˈɔːlweɪz weə(r) ə ˈhelmɪt wen ˈsaɪklɪŋ/"; letters=@("H","E","L","M","E","T"); category="sports"; pos="noun"},
    @{word="jersey"; phonetic="/ˈdʒɜːzi/"; meaning="n. 运动衫"; sentence="He wore his team's jersey."; sentencePhonetic="/hiː wɔː(r) hɪz tiːmz ˈdʒɜːzi/"; letters=@("J","E","R","S","E","Y"); category="sports"; pos="noun"},
    @{word="sneakers"; phonetic="/ˈsniːkəz/"; meaning="n. 运动鞋"; sentence="I bought new sneakers for running."; sentencePhonetic="/aɪ bɔːt njuː ˈsniːkəz fɔː(r) ˈrʌnɪŋ/"; letters=@("S","N","E","A","K","E","R","S"); category="sports"; pos="noun"},
    @{word="uniform"; phonetic="/ˈjuːnɪfɔːm/"; meaning="n. 队服"; sentence="The players wear blue uniforms."; sentencePhonetic="/ðə ˈpleɪəz weə(r) bluː ˈjuːnɪfɔːmz/"; letters=@("U","N","I","F","O","R","M"); category="sports"; pos="noun"},
    @{word="whistle"; phonetic="/ˈwɪsl/"; meaning="n. 哨子"; sentence="The referee blew the whistle."; sentencePhonetic="/ðə ˌrefəˈriː bluː ðə ˈwɪsl/"; letters=@("W","H","I","S","T","L","E"); category="sports"; pos="noun"},
    @{word="trophy"; phonetic="/ˈtrəʊfi/"; meaning="n. 奖杯"; sentence="They won the championship trophy."; sentencePhonetic="/ðeɪ wʌn ðə ˈtʃæmpiənʃɪp ˈtrəʊfi/"; letters=@("T","R","O","P","H","Y"); category="sports"; pos="noun"},
    @{word="prize"; phonetic="/praɪz/"; meaning="n. 奖品"; sentence="The first prize is a gold medal."; sentencePhonetic="/ðə fɜːst praɪz ɪz ə ɡəʊld ˈmedl/"; letters=@("P","R","I","Z","E"); category="sports"; pos="noun"},
    @{word="fan"; phonetic="/fæn/"; meaning="n. 球迷，粉丝"; sentence="The fans cheered loudly."; sentencePhonetic="/ðə fænz tʃɪəd ˈlaʊdli/"; letters=@("F","A","N"); category="sports"; pos="noun"},
    @{word="spectator"; phonetic="/spekˈteɪtə(r)/"; meaning="n. 观众"; sentence="Thousands of spectators watched the game."; sentencePhonetic="/ˈθaʊzndz ɒv spekˈteɪtəz wɒtʃt ðə ɡeɪm/"; letters=@("S","P","E","C","T","A","T","O","R"); category="sports"; pos="noun"},
    @{word="olympics"; phonetic="/əˈlɪmpɪks/"; meaning="n. 奥运会"; sentence="The Olympics happen every four years."; sentencePhonetic="/ðə əˈlɪmpɪks ˈhæpən ˈevri fɔː(r) jɪəz/"; letters=@("O","L","Y","M","P","I","C","S"); category="sports"; pos="noun"},
    @{word="tournament"; phonetic="/ˈtʊənəmənt/"; meaning="n. 锦标赛"; sentence="The tennis tournament starts tomorrow."; sentencePhonetic="/ðə ˈtenɪs ˈtʊənəmənt stɑːts təˈmɒrəʊ/"; letters=@("T","O","U","R","N","A","M","E","N","T"); category="sports"; pos="noun"},
    @{word="league"; phonetic="/liːɡ/"; meaning="n. 联盟，联赛"; sentence="Their team is top of the league."; sentencePhonetic="/ðeə(r) tiːm ɪz tɒp ɒv ðə liːɡ/"; letters=@("L","E","A","G","U","E"); category="sports"; pos="noun"},
    @{word="warmup"; phonetic="/ˈwɔːmʌp/"; meaning="n. 热身"; sentence="Always do a warmup before exercise."; sentencePhonetic="/ˈɔːlweɪz duː ə ˈwɔːmʌp bɪˈfɔː(r) ˈeksəsaɪz/"; letters=@("W","A","R","M","U","P"); category="sports"; pos="noun"},
    @{word="stretch"; phonetic="/stretʃ/"; meaning="v. 伸展"; sentence="Stretch before you exercise."; sentencePhonetic="/stretʃ bɪˈfɔː(r) juː ˈeksəsaɪz/"; letters=@("S","T","R","E","T","C","H"); category="sports"; pos="verb"},
    @{word="hydrate"; phonetic="/ˈhaɪdreɪt/"; meaning="v. 补水"; sentence="Remember to hydrate during the game."; sentencePhonetic="/rɪˈmembə(r) tuː ˈhaɪdreɪt ˈdjʊərɪŋ ðə ɡeɪm/"; letters=@("H","Y","D","R","A","T","E"); category="sports"; pos="verb"},
    @{word="rest"; phonetic="/rest/"; meaning="n. 休息"; sentence="Your body needs rest after exercise."; sentencePhonetic="/jɔː(r) ˈbɒdi niːdz rest ˈɑːftə(r) ˈeksəsaɪz/"; letters=@("R","E","S","T"); category="sports"; pos="noun"},
    @{word="recover"; phonetic="/rɪˈkʌvə(r)/"; meaning="v. 恢复"; sentence="It takes time to recover from injury."; sentencePhonetic="/ɪt teɪks taɪm tuː rɪˈkʌvə(r) frɒm ˈɪndʒəri/"; letters=@("R","E","C","O","V","E","R"); category="sports"; pos="verb"},
    @{word="injury"; phonetic="/ˈɪndʒəri/"; meaning="n. 受伤"; sentence="He suffered a knee injury."; sentencePhonetic="/hiː ˈsʌfəd ə niː ˈɪndʒəri/"; letters=@("I","N","J","U","R","Y"); category="sports"; pos="noun"},
    @{word="sweat"; phonetic="/swet/"; meaning="n. 汗水"; sentence="Sweat shows you are working hard."; sentencePhonetic="/swet ʃəʊz juː ɑː(r) ˈwɜːkɪŋ hɑːd/"; letters=@("S","W","E","A","T"); category="sports"; pos="noun"},
    @{word="energy"; phonetic="/ˈenədʒi/"; meaning="n. 能量"; sentence="Sports give you more energy."; sentencePhonetic="/spɔːts ɡɪv juː mɔː(r) ˈenədʒi/"; letters=@("E","N","E","R","G","Y"); category="sports"; pos="noun"},
    @{word="outdoor"; phonetic="/ˈaʊtdɔː(r)/"; meaning="adj. 户外的"; sentence="I prefer outdoor sports."; sentencePhonetic="/aɪ prɪˈfɜː(r) ˈaʊtdɔː(r) spɔːts/"; letters=@("O","U","T","D","O","O","R"); category="sports"; pos="adjective"},
    @{word="indoor"; phonetic="/ˈɪndɔː(r)/"; meaning="adj. 室内的"; sentence="We play indoor sports in winter."; sentencePhonetic="/wiː pleɪ ˈɪndɔː(r) spɔːts ɪn ˈwɪntə(r)/"; letters=@("I","N","D","O","O","R"); category="sports"; pos="adjective"},
    @{word="professional"; phonetic="/prəˈfeʃənl/"; meaning="adj. 职业的"; sentence="He is a professional athlete."; sentencePhonetic="/hiː ɪz ə prəˈfeʃənl ˈæθliːt/"; letters=@("P","R","O","F","E","S","S","I","O","N","A","L"); category="sports"; pos="adjective"},
    @{word="amateur"; phonetic="/ˈæmətə(r)/"; meaning="adj. 业余的"; sentence="The tournament is for amateur players."; sentencePhonetic="/ðə ˈtʊənəmənt ɪz fɔː(r) ˈæmətə(r) ˈpleɪəz/"; letters=@("A","M","A","T","E","U","R"); category="sports"; pos="adjective"}
)

foreach ($newWord in $newWords) {
    $jsonContent.words += $newWord
}

$jsonContent | ConvertTo-Json -Depth 10 | Set-Content 'words-data.json' -Encoding UTF8

$sportsCount = ($jsonContent.words | Where-Object { $_.category -eq 'sports' }).Count
Write-Host "Sports words count: $sportsCount"
