<#assign base=springMacroRequestContext.getContextUrl("")>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Title</title>
    <script src="${base}/bigscreen/template1/js/chart.min.js"></script>

</head>
<body>




<div style="width:400px;margin:0px auto">
    <canvas id="myChart" ></canvas>
    <span>asdfaaaaaa</span>
</div>
<script>
    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['红', '蓝', '黄', '绿', '紫', '橙'],
            datasets: [{
                label: '示例',
                data: [12, 19, 3, 5, 0, 3],
                borderColor:'blue',
                backgroundColor:'skyBlue',
                borderWidth: 1,
            }]
        }
    });
</script>


</body>
</html>