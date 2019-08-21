let App = {};

App.cable = Cable.createConsumer(`/cable`);

App.messaging = App.cable.subscriptions.create('OrdersChannel', {
  received: function(data) {
    $(this).trigger('received', data);
  }
});